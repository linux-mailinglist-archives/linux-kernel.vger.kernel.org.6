Return-Path: <linux-kernel+bounces-392403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F379B93B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D931CB221E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154301AB51D;
	Fri,  1 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6oeG0eL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848871AA7B1;
	Fri,  1 Nov 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472517; cv=none; b=mooJyoRey1T9FmcNWsY/+hFgJO6zp62iTayceu79ID/PWfFYKP05Z8BrVJRkiQ7P7F0cpeIIuHHUckOupNNWD6HEuCW8vUxn+ArlaRTLUSyTgsjF+ZZdjoVNwPUs/GnCl1axf0v8VW6me9EW5yGcFhb38PnDTsnxDzYj4J24qKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472517; c=relaxed/simple;
	bh=Aez5D/Z2QBMWreCJuN4mdsM+v5hdj55CjDvG7IsGxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqlNtGZgWuimfQe/nO2v4PrkkwXeFn3auhEzWWAtzQwIYywbnAgE8rU6w4zmGs6Gh+BOpIhUn6vdRNOc2uf2Hl2Dfv1FP07zdrtneMLil8xzTYxKLV5nPFK/l2yeD2ujCBopWpCde3yAehjESU/w8HfbBXKX52EZqzN3IeGn3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6oeG0eL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2210560b3a.0;
        Fri, 01 Nov 2024 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472514; x=1731077314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikLF17TGv2d8/HjXENzyIcikHXnbEzedUUKC+eQvlMo=;
        b=e6oeG0eL/RJoUEgpVHOAJmlkuT/O30XGxQKQcJ6xxgTeAins8RICq477wLzwSKIO0e
         POJNtL/kTF5gj85kIgcaakBDlzhGhiSVRwPaUkIL5ejje96/YT68NCB6llFAfOtyPpTB
         /h8A1fIc+1ab7H7xsz625kvaUww/8YyrIDKmZeFVSnj+FHXYtKI2oT2RZ9ZO1mrKhB2n
         X+BwzQRK9cTlxdJqZ/DN28DScc+goJNbIJ/N9cqmiM8IznLW0huesaBrjWsuGB5JDMuC
         TmB1ungs/WXCZP8Xvq4QlK8T4/KKLl0SgKhur9FCm+Z6BA6pKvbhkPYr5hrTRZNcW0i4
         //OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472514; x=1731077314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikLF17TGv2d8/HjXENzyIcikHXnbEzedUUKC+eQvlMo=;
        b=oxAobOtcx0IjRUAIXjaV7EyXPk3Lp000YKRI0zWiE/B7LccGG39xbj/6WJNhFRaUAp
         BjJJ+ig4DiJiyDmqE2DfSqBzzZdfQivAYoaZNt5qzPb3nTfE0ZoF2U0be13FU7rYdrwH
         hriJ33fOI91jgQ1S5gkb9IZ0bMg6VMd2b7yucGXyzmp67NFgx+bSDuRE9Jlf4DjYwHe2
         7bwaZ6SzGqItoGIzmx4c8El94M9QqXVzeTiF0OeZW0AeqkkVaT3BLTmQX4n1CPP1Nm90
         6h1jusgp0PdqetJmGxDzCF1qJoZs8WpofhKuiQ3Y9Bl9Z7ySeQYxtKd+AZu0lZkVNoM5
         elkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHPsop0wrBiktTusIgLInmRwtkxdmti8zoxIT4G+WmuEKzXCNPOfyLWMkg4T50ugAvDLP5jU6XiqEzGif@vger.kernel.org, AJvYcCUSnoaHxQJQRwRKeYjXNNaTLEw8BCw3A/P8mmN4R15mX1vRU2ymfeDiwuJOGE/+IQvMRc2He+SHncJg@vger.kernel.org, AJvYcCVlQwDfoGZi8beYOJI60PcAHpQz9FJ9SzdN6/or0L4vnL4ltSlo4pvynwcuvY+mF2+cIW5QN4qMNJQ8IoI=@vger.kernel.org, AJvYcCWoLL0EMhrHyQGINONtsqeFMOpponIw9d9k7p4SEa641pndABIsK82zsP+aRnpllCckHvkqwENRp4NP@vger.kernel.org
X-Gm-Message-State: AOJu0YwZjSTk5EMQqvEvsF47Aq72zsnKGpaq6z6Z0C5hEueBnop/nx5E
	mWLaqx2xRinaIW36cOTzKio8ggop4WpH9JhjznQ3KDiXVPSH+NMB
X-Google-Smtp-Source: AGHT+IEud0i2QRxm/ssibxG0ytuDAv7M+mnTsOZohBA1h7lUg1MTloaGNER2mbVW0mDknyn5OpCdQQ==
X-Received: by 2002:a05:6a20:4c21:b0:1d9:15b2:83e with SMTP id adf61e73a8af0-1db94f6467emr8939450637.7.1730472513686;
        Fri, 01 Nov 2024 07:48:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8987sm2745643b3a.7.2024.11.01.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:48:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Nov 2024 07:48:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com
Subject: Re: [PATCH v6 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
Message-ID: <319d7395-680b-478a-aec3-08bae9177f73@roeck-us.net>
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
 <20241022052905.4062682-3-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022052905.4062682-3-kcfeng0@nuvoton.com>

On Tue, Oct 22, 2024 at 01:29:05PM +0800, baneric926@gmail.com wrote:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> The NCT7363Y is a fan controller which provides up to 16
> independent FAN input monitors. It can report each FAN input count
> values. The NCT7363Y also provides up to 16 independent PWM
> outputs. Each PWM can output specific PWM signal by manual mode to
> control the FAN duty outside.
> 
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>

Applied. I did fix a couple of the nitpicks raised by Christophe,
but I did not replace for_each_child_of_node() with
for_each_child_of_node_scoped() since I can not test the code
and did not want to make a functional change.

Thanks,
Guenter

