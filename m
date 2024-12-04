Return-Path: <linux-kernel+bounces-431823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F79E41CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11DB161D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDA1A8F6D;
	Wed,  4 Dec 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZKxUaxLc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C51A8F66
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332067; cv=none; b=QeEMWLHXWDq0PWU5gwK8Y/CKF1ctiFHowEFhpfIee4CekpWoE4A1I5mO/aYr/r90ZqJj5PE7wtlwclR688ScVFblp4+WY9HMgraDsd8KhI/PMtj8TJxFAgLnAEd9uV9PeE34N0V0XvAw+D9R2NzEzLAS/ceNTrcWHm+JDGviduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332067; c=relaxed/simple;
	bh=5gCPZVrrifqnSFAQWHbs+OifVGQuIbzw/66LkaDUaWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O4UCuVNGwYuvlFkEZgozf9t2inPrU11lkZVDyAHB8+MaFuA4tq8DsTvWVbBa5H3f14ZvlIXXlokb80cTQvf5IRsHDP3sof7kp3r0kpJxepzghZX7RABIFhD+UsS85/1hXAl7lh8ozhn6x256OCKUI+D9LAOWGzFyYgEB/YFAHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZKxUaxLc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215da73e256so26415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733332065; x=1733936865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nili2EeXhBBnCR9E7SrWkjme6AdYdFkZANnDcpM0kP4=;
        b=ZKxUaxLcWN7eCkXKCmy4YzLKJ/ULa+lNpDMxoStVairfiIesM0k51wCtNS1ZC/Q98e
         m0edDM+rp4b4mGTF/WMmoEJDpOIJAySG6fOUChnt5Bp4y4i6jDwPR+RTt0prZh531MFM
         QM6FAXUfqAjAfQKzZWrcFTNL0UjBcTClMp38NXkhtRssZBKaeefyzuDhgvTL+M6C4lUV
         5ME+RNIyvPBQNbqJtXDqt7IIzf+/Qfxqutk1MKbGMh2OVXfo+k0zUW9DFKpT5TkpeJMi
         MTVy+XklX4JGEqkckApvuQa/iQCgeZIo+FyrfL2U+KnN9mEXTe5mkvjFxQCaiMaWxAHO
         nzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332065; x=1733936865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nili2EeXhBBnCR9E7SrWkjme6AdYdFkZANnDcpM0kP4=;
        b=KMmYPuF6gpxow2yOPXdUIB9L/y4OolR7dA7DGhxlTO12H4cGYI2JZQEBZHJEQ5wFey
         8CYb7DrnnJRxkep7aaomUsJKILpzNfJlDTEk0Re03sL7SmYYC5n+p4a2B25ADO7nMiFJ
         PB3K/V7kxO7o098atimwnz6CAJOdZtwwQsADQq3DHDrBHHl1R2+5i/94L8/zshzwJ+WH
         vSKhNzWl4VSZ36YpBvqhYdNEo/6tEpNt1wW90TjK/ik5o/esEkZr2iVRBvhhZJxxZMVg
         OxlUxzG7Y0b8fpwO2X7rkvnn5DBMlDfP/P3//XFD+hbkhoFLeFSmUnhEt4Z0UEYB6SXN
         a+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV6daJ9PfyFGkmxS6QASxn2xmU0aNfia0CuNgYtPU4ccb+tTNYbzg49MyIIe4oAlAasjoX2hR2Tm+un/BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltyRXHFCVCV9U6k0aXhVHZDbo677aAakQZa53rZQ5Qj0Mn/np
	3uW+ANcvpOSiEvgg9rwq1m2YYMK3PUsLekWra0fYDW8I89PSh0eGk1XlaKLRyfA=
X-Gm-Gg: ASbGncuw6T8z1xW+JiZaHeSGTFPx3cAheu+yjkP7luDdTQGtkeZZ68enrsvzEEcXNHm
	uOHt5ifbmSssitLd2c9QXxoRE9KOXPU6ROp8MjGcrllfbYExqNMRdGXgyqvOPQPNpqBWtgtq5hd
	z+7MMatKCuTp/Fx4Lgoy6LQ8R78AUn+VzO0kSV/D25DyjzpKgLsiaecdFt8d9LqOa19Jd8enkqU
	tl2gOoDAYNfn0/0lQaff7yd0LLMgdKniEntII/2HbJhEM/DAJxn3gVF8g==
X-Google-Smtp-Source: AGHT+IF32nHEnke/iHlli75h4pEZRfldBD3CafEcKSm22g4yIOJgDo86HfqDrWjiytqDSkug/TuvvQ==
X-Received: by 2002:a17:902:cf0f:b0:20c:af5c:fc90 with SMTP id d9443c01a7336-215d00d0769mr66857345ad.49.1733332064725;
        Wed, 04 Dec 2024 09:07:44 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215650b3cc1sm76772355ad.0.2024.12.04.09.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:07:44 -0800 (PST)
Message-ID: <1ce3a220-7f68-4a68-a76c-b37fdf9bfc70@kernel.dk>
Date: Wed, 4 Dec 2024 10:07:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_sqe_buffer_register
To: syzbot <syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67253504.050a0220.3c8d68.08e1.GAE@google.com>
 <67272d83.050a0220.35b515.0198.GAE@google.com>
Content-Language: en-US
In-Reply-To: <67272d83.050a0220.35b515.0198.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: io_uring/rsrc: get rid of the empty node and dummy_ubuf

-- 
Jens Axboe


