Return-Path: <linux-kernel+bounces-337074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954949844F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233F0B239F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448811A725F;
	Tue, 24 Sep 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y7bxKniK"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408451A7255
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177881; cv=none; b=tHJRtjuCXpC4tRLseF5Zc5rqwGmgXCYKZsanlsrWeC24pvkaz0Z6eBcSGSMyw/HTQ/UO56NeuHFwOADr3OqdmxaK1WYEtVO/3atfAObbiMtCvsis1/Ej/myvhTUe/BNxKhKMk8pt2lVpDOFx8K/aG0a4hEwTWt8+8wL0wvvkvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177881; c=relaxed/simple;
	bh=p0BdZAZh1ZxjNZymKWKLfbu3HHT15r/YJntFkUJ/mJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T/lKiKzGizKYz8pWjCyliX95KofZoCZfr+2vdGh+GMLFlnULTUwJ7kZfl8CvxBTBIDgeS1YjtXmfw1wjdytmdraIvQXWu9tKf41WCLQjMAa7FMVrH8fy4Eh9jfuu0xKxv/nLKfbq43mJnSjftUwMb46nMU7/MfR+8FKVCCO4nsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y7bxKniK; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6de05b9fd0bso43553537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727177879; x=1727782679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zibiU5NcjA/42kDb+GdOf+oExsB2oKos9l/xA59FG+c=;
        b=y7bxKniKY86y9PZuE6yQEkskNbx8nfWZ2NE/oxrJgZqg+RL71Xeq+cnRA43X49s/cp
         cUbUPc2pN2V3UKg6FiDL3tDdBfLt9jB9r3tn/oFHr/5C4k5PcHIOsprtrRa/Tfyi04dc
         Z4AyQs7kv5lBC7zY5cq+/U4CxgYLsccwsApl60wzTOjfKSp4domyR5MgR7g8H0pXG/2q
         KoTcq/BgvARjjMy7tL7HG9C2eXtNlZFK7lwiDJmeC77jC3IdEvOx1/ZwAF/AUXaIeKlS
         lmo91TBPx3oy/MuoiFsZ4ztom1oewLyQv8AoKEgHivKrv17Bjjk22eMd9Newrm22oXk7
         ASOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727177879; x=1727782679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zibiU5NcjA/42kDb+GdOf+oExsB2oKos9l/xA59FG+c=;
        b=D6ekCyZ85qYxrN4Yre3qs5oV0p6xy2kWXc4cWHvKLS47CoNNfvxq46q9YEnhl5Fxs6
         F2HZ7TmlShPN1Q9817bwlQro/p8u1QZFLOSj4DNV+uYxceymkcRCE0qu+b1mJgITsxYD
         jfKljQmFDesH0XSxoRFOT/44bdSiTmienSYbCgruFti5S9Q770lKNkOWsUBABTuHpIg1
         eJfJXx7lbgdeL93HLvWY0uY38kb6MKOTP5l3g/i5u/V8YmVkFECK93+iqKaka9UUqEFW
         lyumE3qmVkbMI76KR3UkaTPdq5p7f2KI1dkwcH6I1aGD5iaWRos0mIQRN5y2aGHdI/1v
         QLuw==
X-Forwarded-Encrypted: i=1; AJvYcCUGXIdD6U35ggluzz6ihgqc+4zykcC5yDmUswDgkW1mf7NRNIiNHbvEVkYszarKBA7pKunhTontzMca1Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsWvUwTZj2BZTPYuaDI113rha1TGh2K6NfmlJlWXYJ04+yFcy
	sGqy9ggrLT1X2LmV0ItKaQ+UkyA0srHmTAtdgxCXXQRS+Vsp+Wzrk09jlXYd2sU=
X-Google-Smtp-Source: AGHT+IFwnf64MjHXe48n9DmAsLZlpXhJrVcdnslHAZm20aRIy+bhv3thVqdhppairRNPU4E0vI3utg==
X-Received: by 2002:a05:690c:4243:b0:6dc:d556:aef7 with SMTP id 00721157ae682-6dff2b1b2b8mr84275797b3.41.1727177879192;
        Tue, 24 Sep 2024 04:37:59 -0700 (PDT)
Received: from ?IPV6:2600:381:1d13:f852:a731:c08e:e897:179a? ([2600:381:1d13:f852:a731:c08e:e897:179a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d27d2d2sm2104957b3.117.2024.09.24.04.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:37:58 -0700 (PDT)
Message-ID: <b0140219-56f8-427d-9ca1-d3eee127a5e4@kernel.dk>
Date: Tue, 24 Sep 2024 05:37:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in io_sq_offload_create
To: syzbot <syzbot+71b95eda637a2088bd6b@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <66ed6edc.050a0220.2abe4d.0014.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <66ed6edc.050a0220.2abe4d.0014.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a dupe of something that was already supported and fixed, it's
been sent to Linus 2 days ago:

#syz fix: io_uring/sqpoll: retain test for whether the CPU is valid

-- 
Jens Axboe

