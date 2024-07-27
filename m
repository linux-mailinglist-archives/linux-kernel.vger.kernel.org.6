Return-Path: <linux-kernel+bounces-264116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20793DF13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8DF1C20D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60C6CDCC;
	Sat, 27 Jul 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqxpCX1d"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B59143C59
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078160; cv=none; b=T66rSacV4CWCW0lCQDgXINcEV2upZyErcWW1LknuAPtfxFzb3C2FIA9SIw5jwojwMXxNLXAnrCxdrAo+xahnSf6Rks0U2BGxcZ5v6N1v/xwMPW/44wBYkolQ+gdeVU4OFEOJRmk+38YtExwjL+VuK6eIjcR/X4XbdI1yyGgs48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078160; c=relaxed/simple;
	bh=V+YDUSc3nGYr1WxRfHK9/D7VF2Nro5Dl90xbTvXtMhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THYmX6P8ceOM7STymnLKks4FfA9tXROfPN/4WhpuztZjsoppZZ/ePWLigZImUtoVtXIhLgbgaAdYzFOBi4OAoT9dFplWxTbKxYMCYzwFqlCA5O8WsHr65SXvZHeAnV5PRlXoGv2r7f4BXr7VY/YxrW82qKhh6GYsPJd0CJWmnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqxpCX1d; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so31159941fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722078157; x=1722682957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jye8ZO2/pki4i7qm4KDwuAM4qsHOMHYsZkmnjiOoEkk=;
        b=iqxpCX1dkxM06GEE/8m4VPEIYtPVSswuO+bxJzFEisOa8Y4zk81NosIQs2tJHsTcat
         K07C2H2UqVQjfHaaKts1/O6X/RmKZAhTvJr2xmei3oHnh4lXD7KAVHgXmKsfXiLfNqal
         R9wQWxQZv7PSOabudgky36PGRcaUnyyOaKOZ3cmca3OpYquCwviBHzCPBlGwJiXNyH88
         hQgxy2p32kUqLoBYe7FBitroj2tAX9Jl8Vm91lIjHbcdJoJA/f0lZ+DixZVgupSe6AWF
         JKbEYQGFL8EWuJFpFIekbD2ZRQLY4T3VJNcleIWQjUUrKQbSXkVFzTixReU1uo8PuGyH
         rWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722078157; x=1722682957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jye8ZO2/pki4i7qm4KDwuAM4qsHOMHYsZkmnjiOoEkk=;
        b=EXxnAsaRMYy6KKXf5Dnd+/tlgwdEkCAMg4b2oAMj+CdJeo6azcJM1QQez9MQR9itGU
         yQU6AWf/Gj1N1QWo+frbv+m8W2iLHQkibk3VcT4jkU1JEK79VbPLa3ccI7ak1IAKNLuL
         V1NmSUPFgxmksL7w1LN3aYRrZ+qcG0TMGFPB6D8KejGtjoYIT6M9ltIcrMRkpIPXM64B
         kwSedYHmsyD3rShXJyvypNWrUR6uLBpw8/SYmj1/Mldd2/uz8/4IYUM5yuZPQpbI0v7o
         5UUIqX7W2tWwtfTqDab1YNXj5wHF1eiTvJCDrMVm9JLCkjgdVEwwVq+Okv10L8EHZLZ/
         9Ycg==
X-Forwarded-Encrypted: i=1; AJvYcCWKhvsREV1c6jd+THFDRnKxtseil0/O3mxPQak86uwCnwMbz0LLlH0Z1kTDJnop9FDBCW3m2NjKD11qAuivscAWK9ENQFUqkQLSVvga
X-Gm-Message-State: AOJu0YwUK/QlQrEhIci8FIAspffiuimoJnnd1qapKavDZaYvRsmadktY
	14iEe2RbD2rtRzBxByVemDxEKwvc+lwMf2rDjvvrYt30yMdxwv8EHcZs/lO8r5c=
X-Google-Smtp-Source: AGHT+IE9K63HbHii+F8cpEh7ccZeL65+H13yCLffjMNQtukHmqqedaSKiBaVF/n7Xsgj2haKQ1NhgQ==
X-Received: by 2002:a2e:95d0:0:b0:2ef:2dac:9076 with SMTP id 38308e7fff4ca-2f12ecd2742mr13863451fa.11.1722078156689;
        Sat, 27 Jul 2024 04:02:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf53bc1sm6887531fa.58.2024.07.27.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:02:36 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:02:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Add status to UCSI power supply
 driver
Message-ID: <5bnu2usyw54rlqvo7msq4ve6rmsk27jeouegpwymg7m3zbnx7m@x6u3gi3yscv5>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-2-jthies@google.com>
 <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>
 <up2clptjacrc2n2ibzkpv5od47pky6im3pzzgjuymm4xd7ielu@ulg7lb2u5lih>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <up2clptjacrc2n2ibzkpv5od47pky6im3pzzgjuymm4xd7ielu@ulg7lb2u5lih>

On Fri, Jul 26, 2024 at 11:30:37PM GMT, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jul 25, 2024 at 06:31:00AM GMT, Dmitry Baryshkov wrote:
> > On Wed, Jul 24, 2024 at 08:11:13PM GMT, Jameson Thies wrote:
> > > Add status to UCSI power supply driver properties based on the port's
> > > connection and power direction states.
> > > 
> > > Signed-off-by: Jameson Thies <jthies@google.com>
> > 
> > Please CC Power Supply maintainers for this patchset (added to cc).
> 
> Thanks. I guess I should add something like this to MAINTAINERS
> considering the power-supply bits are in its own file for UCSI:
> 
> UCSI POWER-SUPPLY API
> R:	Sebastian Reichel <sre@kernel.org>
> L:	linux-pm@vger.kernel.org
> F:	drivers/usb/typec/ucsi/psy.c

Or maybe extract a separate USB PD PSY driver, which can get used by
other Type-C port managers (I didn't evalue if it makes sense, i.e. if
the TCPM drivers can provide data, I just assume they can).

-- 
With best wishes
Dmitry

