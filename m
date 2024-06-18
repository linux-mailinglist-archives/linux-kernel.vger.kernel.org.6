Return-Path: <linux-kernel+bounces-219500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BF90D37C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57941C2500E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2513C81E;
	Tue, 18 Jun 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MtcCU28U"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52713C673
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718246; cv=none; b=DmDtAwY8uYwA6ZCrhHBrFKoaFkuQ+O8HI2rk/pH7fvBuiaQD6tE6qTSoyjwPy4HHHFkBCkzmakKyLRT2z0DsAG4+3f52vW1J8GmuZJxAjtAyyhE0+LqxnlQmYcdyBAmds4Hol02S8wXKexMRS8ryo2OGQ5MnVRQKPvGIiJhuRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718246; c=relaxed/simple;
	bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeRzG35gLFOvEyRZGNJgdI8yLaKeXN3AI2MLsVoH8On91pv5AZzJoqiFwjtO/3PY4eG1tx/X9FyZIkuyJyXG4j6Nb2yxfYx48qPpiZ0oDuM4JN0FAf8GNe8MbJJ2bvqkH1gXCTllsN90xdV4xTVzomQ++fS45Ma4iazGUCLqNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MtcCU28U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42108856c33so39992465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718718242; x=1719323042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
        b=MtcCU28UrwqJOxUFqDad9a+QZEZvZ+XndEEL4mWc4iw1rlDegacCR2HKVeCTD2PEar
         vE9q+AKxhyOc4xRiVOWHG78S0h9RPGm9u42ndPxoYF0uDBmimUR4uNbgC84UfuAbI6rQ
         0vgyFv9kCW4XRPgplU2YvKOU2R3VfZyYiYsOK/HtbXX1onO4gtZo5OhZARdhbABvPSPX
         mkiLuz2TcHNKCEBUBfeov9A0+IhHnNnESllpC6J/xtoSGhjh79XSSJHtwO5Dl6aHVlhz
         MWzvG2RpNkwVMbMM8d13RzbG8YJVylP65D3SgbvKj/1DKyGRFWaoHi04pFUkRIXr3WL2
         300w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718242; x=1719323042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWikXjpkRj2Id4OGHyodH6vOtWSmxTQcha4p8kJZ9Gk=;
        b=uY+esvmJtauCoEEmerDxUWpWu5ncufARo9h7OACumT1KopC/pVUKY0d3rvBhW86SXH
         3TG6pZLZoNrR9lZKA/BGjt7vi8psGcCpxZmfQ7G2W8ZUBIGwExZLOjkfNixm5YJyQHoH
         TkvYetqRfXDc0xaLR80bFdOdaDv8GaBXRXE7w8TtFONcJZ+MzDFfRSn1/d52goONS26m
         OsEBZ/+weueEOE7jaKxCFz7+8QcLpVmsn5oH9jal/voMfI9a/g5pqOD7ODwIvqs2RlfV
         YsZLg9UBZL9pyMs4zt8cG2T5t85YdIuIxiPQKX6pxc2a/u/7HPkqlpfw8GOsbf8kL0Vg
         tX7g==
X-Forwarded-Encrypted: i=1; AJvYcCWnWP0C0pmEWTMEIqHO/jOvb2NDg0ZmMT7TBHzYFhC/UKemruXpsWsFNuylgQeqSObcWmVvLRV7dgi28TC2WRM5+vN/gRKT1CENxVJ/
X-Gm-Message-State: AOJu0YxBuUkB7jedoufoiQk+JEm+nyLNlPFu1BdfEtR6GsBQbRK2hJ4U
	Gyf2K5ciV6+9Vw5hhYFTYaD6dnv8Cp+horXKkDYJ2TxgabMjsAL0uSuOrmd/LWA=
X-Google-Smtp-Source: AGHT+IGT9NyeAwKGPItuCbiIYyLLhAcu28obA1HAvzNX5/D53inMb/HpuoISsfJg4pIy+rUEWHwkEw==
X-Received: by 2002:a05:600c:3b9a:b0:424:7443:e6d8 with SMTP id 5b1f17b1804b1-4247443e76bmr8350025e9.9.1718718241629;
        Tue, 18 Jun 2024 06:44:01 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm227480455e9.45.2024.06.18.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:44:01 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:43:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
	przemyslaw.kitszel@intel.com, horms@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] ice: use proper macro for testing bit
Message-ID: <ZnGPHez662_8E7AA@nanopsycho.orion>
References: <20240618111119.721648-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618111119.721648-1-poros@redhat.com>

Tue, Jun 18, 2024 at 01:11:19PM CEST, poros@redhat.com wrote:
>Do not use _test_bit() macro for testing bit. The proper macro for this
>is one without underline.
>
>_test_bit() is what test_bit() was prior to const-optimization. It
>directly calls arch_test_bit(), i.e. the arch-specific implementation
>(or the generic one). It's strictly _internal_ and shouldn't be used
>anywhere outside the actual test_bit() macro.
>
>test_bit() is a wrapper which checks whether the bitmap and the bit
>number are compile-time constants and if so, it calls the optimized
>function which evaluates this call to a compile-time constant as well.
>If either of them is not a compile-time constant, it just calls _test_bit().
>test_bit() is the actual function to use anywhere in the kernel.
>
>IOW, calling _test_bit() avoids potential compile-time optimizations.
>
>The sensors is not a compile-time constant, thus most probably there
>are no object code changes before and after the patch.
>But anyway, we shouldn't call internal wrappers instead of
>the actual API.
>
>Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
>Acked-by: Ivan Vecera <ivecera@redhat.com>
>Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

