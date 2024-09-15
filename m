Return-Path: <linux-kernel+bounces-329810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD9979648
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBDA282A11
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B01C3F20;
	Sun, 15 Sep 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6rgGub7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BCB1C3F04
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726395175; cv=none; b=UEF0bFRmqKgJV+gmNbXO1046g6mHqXSTeoXj9+ILVj1OThzznuxXoGMk7HwrgiKX07QxF47RMT9yaN80ciEg9Ew38DbI3DKM7KHOOixc2RIHxuVQ4vdveFnW8aYttc4QTXZDLSnQW1eV391SuHScx5fbOzcMMge6tInO3zbSMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726395175; c=relaxed/simple;
	bh=YufrWgDvYHagdRJ8Eafei4Z0REg/DPXuZsNa6mm46Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWRu2yhGveppci1vgy4g5Y2iSuZyXpdKpkDXmEixqfi+/s6/5lltZf+W5E3KVeyaybQ1ERjsdzUjqnMnf0DeNP1z4QGayxmdiM4ZeiHnFKOS6euzxQCtSqQ7VakPQb05+XbEkANJ3+xeaslqhRU2Wi7l6VvaW+K93EPcYJNUeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6rgGub7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53654dbde59so4316831e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726395172; x=1726999972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3b+re0v8aGDDcxjlUeI6whVJWiks/9YnhQ8GIAVylM=;
        b=B6rgGub7xT/kG9EI5r9H8lB2xdNnyqk/WZn00wdRwmZmHAQBDRJQzjlk7rwwJfHdFR
         0L34oOFA2hSyXvQKyI1hAI6AbjTW1L5jKRNtDRq6Wu0zO0qblK82H+gAsYuhXvq4fdT7
         RBxKBDLvFtKdnV3cvFQ4v3zFvMAqfUHuSwHA/SaqqLa0hUUJmjhOs4hEWmggwkWssJyn
         GdF1eG7GYh0MYj80uUg+6qJZNFKzrS6GKFgLyvVuB//fqkTSGhtkpi8TbTioxXIUe01h
         qrNyaeeup8SVmFx9Z4Dd7Kg8X0jEZ4ZDZEjD+ZZ7cCjGUvt5UKRjMlEofIV0XzAEGlEO
         MxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726395172; x=1726999972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3b+re0v8aGDDcxjlUeI6whVJWiks/9YnhQ8GIAVylM=;
        b=wveA6plSlEw14ElKz3hjKzlKNJJK0qaPC3ZQhqzkcovTPPLq5Xgz3Ttiut6IaZ88bx
         cTjxmItEVc+BgqrG4+5d6CY8J36LV+DQvqCfXDU0y+JtFAWTyZt0vMSjoQGe3mftDps+
         aaC4CBTpttATHBRsxOIZYF9DVAzQkqyVzsN+Ijupuh4g0XyOGAbj/YSUB6Aq2wxO0ZVF
         WG42I+w3DYAK/laWKUW4ONHlA1howc3S81ynxYnNvVuyyE2cp03yvP4BacaYb5mzWnZU
         RSJBrR/qd3Sdc5HhW1ioRqUMHuYK0zqxnqCZEXVSlRqAX4EUV9GE09/8fP31RXDb96+L
         f4ug==
X-Forwarded-Encrypted: i=1; AJvYcCUccI79oSox8jblB8o4gmbm4v7EoFFfYxz/GPkEov5TUbcFlbhj56/9tOXmAiiVaRrhmN3QROxEyK+1dg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxF8YgkRqUEXTIe9tRjMI8yGUm2Xe8d6srYibVqIr9G3WpUzF
	HSu+1DPQsAqpaeZiKpVz+4YsewXH9lcb8f/XWDmWeLZ1+4THO6kU
X-Google-Smtp-Source: AGHT+IGFULRwl29+zBkgy+dcU0s4TIiCfqrud8aX30zIW4nAlXdSrXZwnP6OgjhggVHe0DMx5YyVYw==
X-Received: by 2002:a05:6512:3d93:b0:533:32cf:6420 with SMTP id 2adb3069b0e04-53679075a23mr3746955e87.8.1726395171536;
        Sun, 15 Sep 2024 03:12:51 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a8635sm518588e87.217.2024.09.15.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 03:12:50 -0700 (PDT)
Date: Sun, 15 Sep 2024 13:12:50 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to
 PinePhone
Message-ID: <ZuazIgLz5PP_Z8Cn@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
 <20240908214718.36316-2-andrej.skvortzov@gmail.com>
 <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>

Hi Chen-Yu Tsai,

On 24-09-09 16:08, Chen-Yu Tsai wrote:
> On Mon, Sep 9, 2024 at 5:48 AM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > From: Icenowy Zheng <icenowy@aosc.io>
> >
> > New batches of PinePhones switched the magnetometer to AF8133J from
> > LIS3MDL because lack of ST components.
> >
> > Both chips use the same PB1 pin, but in different modes.
> > LIS3MDL uses it as an gpio input to handle interrupt.
> > AF8133J uses it as an gpio output as a reset signal.
> >
> > It wasn't possible at runtime to enable both device tree nodes and
> > detect supported sensor at probe time, because both drivers try to
> > acquire the same gpio in different modes.
> >
> > Device tree fixup will be done in firmware without introducing new board
> > revision and new dts.
> 
> FYI I've been working on an in-kernel prober [1] for such alternative
> components. This does not require firmware support.
> 
> [1] https://lore.kernel.org/all/20240904090016.2841572-1-wenst@chromium.org/

Thank you for the information.

I've tried to use in-kernel prober from your v7 patchset [1] on top of
-next and it worked without any changes to firmware.

Since there is still on-going review of your patches it looks like
it's to early to submit my changes for review. But I'm ready to test
your new patches.

[1] https://lore.kernel.org/all/20240911072751.365361-1-wenst@chromium.org/

-- 
Best regards,
Andrey Skvortsov

