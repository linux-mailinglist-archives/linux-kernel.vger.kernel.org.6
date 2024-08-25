Return-Path: <linux-kernel+bounces-300576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DB95E557
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639182843B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA816F262;
	Sun, 25 Aug 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RdNqJj6G"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB43B78D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724618530; cv=none; b=UTiG/0y/Yv9kUjLbrGE1u6RSxxrbvcgrlu7yRmb0Ys13cMyhpaJ/7S0Ou3XbdWlJHZA8PHiML0ASdiDF71cUepQqknjfEUdNWc4f7LGDsbW3y8TckCVTx+kjhcQ6JH04RYj8XK/GNidOASkpjaYGfVmgVZmcHZbr6s2klKhLO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724618530; c=relaxed/simple;
	bh=r3xn1fjXtcTZl8edBo8zoh5Fcl6d/czsBH6iAELNJsM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tBeUkdaXsyazqdJLE9TW+5x2VoE2X7ce/gH5pdKhBeFsrYlGNh3n1nG/r2bKzAAd16z3R8HsQjPbrXuR88sLnxuv1J+kKg56VpynE2phcbhhdf7+Le4b81DyNb/m+/AHHoNabIiSgzaMRRZENa1XrYnjK08I52fOq5FltLm/7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RdNqJj6G; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5befecad20eso570292a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724618527; x=1725223327; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I5eaIhTOuu7Bwecqwb9kbtmtPB9TsVLIgYezcaQD2U=;
        b=RdNqJj6G0JBBTa4j6XpgmjkWnFFYI9JJeSfEV3/aDn3l5UWD7lUgMVyWmU9EUhPTEk
         Hk6rpUNhSNAJXM6TipH1vRgZsyvLSY4p4HCp4c3PW4QDZmwj1kKP2KsP1n3rrI4QjJ84
         zdmoI/2L2euvfJeOqVPoPgRuxooFuLo3jqnblDiuvfgnys0uaRRxR/GWtdqQnv0qYbjL
         rVmiklFNZ6J1h12rHtrdHQuVCu6aolCrjzbufLvzR2z/FfcXdxkXm3gUuL3x9uhFFJ+1
         qh01b/KnnyotM5UUzf9a0w+ehWFfEXh5V5BVcbqsAdNDSf9f8ahkS/jptARJN6UlJL/r
         1L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724618527; x=1725223327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I5eaIhTOuu7Bwecqwb9kbtmtPB9TsVLIgYezcaQD2U=;
        b=p7GwGlaHjWU/u396rGwwud1rcRkfBSkZ0sNUHZuQqQdLdUgdq7bpe9eKnEJSyLHNxE
         alao1ZvlD7XtSs4YZsqcDh5SvxlFh/lv1bR/cv0VjKfj51n/LT7nH685z9TyJGmUAP8X
         QvGME42ox7yAkTMeU4sTVbA0zRWg4YT521MUfxKjp9qnjaIf7aT1/wxvdWjJZ29JlBQo
         LYmvaQMYxzFI2ka2d8dxYPT/plSeuUdy19/UL7GTNcMW/hIdxUXZZud74w84HiIeMFRk
         tcrLeOizbnD6jFryy+Px8szmPbPn+0Q2z7FTbsz76GRoUjIyfCgD24QqHDD5YKWuyjfr
         1aiw==
X-Forwarded-Encrypted: i=1; AJvYcCXhB0WgCIR8I2nyL/3rkUA4pxPehz0VDk9wUbaSAfCH/5iKbL6t72vAb+4RfNvSW2VIAOBxUHXyN10akYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFd5d1qcvguZv/ndmzb7dY4PVQBsZxl6x1FyCsp6B01CeZTKld
	OZi3p1inm/yhsrqnY4f0taVQ1MPpu2ii3F1YhmHcVW9mYaBItlkyjG3OPJgeWZo=
X-Google-Smtp-Source: AGHT+IGWrOtzUcJg5h8Rm7rriW5rbRJGNmxlSzv+N7+hdFaqRxfoh1QPwhLdabW+elDyhtoxJ8W/Gw==
X-Received: by 2002:a17:907:daa:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a86a54bbc5bmr299121066b.8.1724618527335;
        Sun, 25 Aug 2024 13:42:07 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5ffsm579976266b.177.2024.08.25.13.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2024 13:42:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] bcachefs: Annotate bch_replicas_entry_{v0,v1} with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <cqyrlfpjprkwdteljmtcnl3z2etzitvodrlv7v57tuizvklpcx@gg7dbstowwd6>
Date: Sun, 25 Aug 2024 22:41:55 +0200
Cc: Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4911B345-A37E-4FB9-9339-83029033EE4D@toblux.com>
References: <20240825133601.24036-2-thorsten.blum@toblux.com>
 <cqyrlfpjprkwdteljmtcnl3z2etzitvodrlv7v57tuizvklpcx@gg7dbstowwd6>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3776.700.51)

On 25. Aug 2024, at 20:43, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> On Sun, Aug 25, 2024 at 03:36:02PM GMT, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array members
>> devs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Increment nr_devs before adding a new device to the devs array and
>> adjust the array indexes accordingly.
> 
> The nr_devs changes are pretty gross - please add a helper for that

How about a macro in replicas_format.h like this:

#define replicas_entry_add_dev(e, d) ({
	(e)->nr_devs++;
	(e)->devs[(e)->nr_devs - 1] = (d);
})

Thanks,
Thorsten

