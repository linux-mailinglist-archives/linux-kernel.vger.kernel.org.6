Return-Path: <linux-kernel+bounces-569090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC94A69E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353F2464D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB791B4145;
	Thu, 20 Mar 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MNc2KZDW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA528EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439011; cv=none; b=P90J/nAYrv3/kjFfvqI4txo2nz8eD2C3MxYfpOi7xO1XqhNh7AGMpNiOz9uPGcBeKeNuQXvWUrFXAhjsA/ODR/jeFfWFaZh0bVQb2cYRVxg2Y2l5IYyfHuLiaSxKZf8Q5VINRPlZLum/dtd9n3G8g8u1dEoGiqh+t1tcG2jaCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439011; c=relaxed/simple;
	bh=P3SiIqeVRj8iaEhNM+RBJmR1hKc8A4iDN9+dTEaaRcY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A92hsQpwXW/mCJg0xr3KU/5/UPD+f/M6x6xGMxy3GUwH9aahbEeoHMv4tjglJYqeIK4cUOKBkDajbOgFU7o5ywtwfqGK94EwU1MOwPwFMuT0YMcQClWDKOZvz2CRqSsevaJQaOrErSEEqvh1PH3U2GQrGVx1lDOY7IQZBZM45gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MNc2KZDW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4178D3F59F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742439006;
	bh=B6K+THwXySxBQJQOsWXD4oxCuQIyOq0AdqsbklaeKoI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=MNc2KZDWkNTrQrKEU4WEFt0aQkhudHoRADEFdl4WXt+gO77ygT6rd6oKSrAw2RSkN
	 s9nkqo+q3AbPH8tpyx9ZDJa9vMitKgIYqoGcbrH78lsTEdSQ0GJoyXswdYURiPExLW
	 A+RDTpqgCdPgFP6EmkNxzOquFTD+j+xeoxSg0zq9EIBgfeEr37pxiU/BeaILn32Oyt
	 /ZC0nVUUny6Ny4qtByq+OsPu6Yr/A4aFolK0mi/YIXSMKrvg8ypeCr2dNBhlNfJpyL
	 QhglWQSH91RrRYSiq2+z8FhnAe7lt7ZB9N8BglMRIHqV5hYi/FX4ylIV7rG7deS3sn
	 ETnAGZarGU+ww==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac27d8ac365so21893166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742439004; x=1743043804;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6K+THwXySxBQJQOsWXD4oxCuQIyOq0AdqsbklaeKoI=;
        b=bKu/071R0F/cHZ8OjEu2mulb5OVvp2nKZISn54WMJ3B2N7Ih14iscIT3K1LB7EC/Yq
         uV0JcoJQ1dwP9L01QbkDgCSYbyr/726am7HasE2Tt3vagqGXWs47X1ofutQjjqCMabYM
         52dad1sQNhSO+WH0udUlchuY5flG8PE9MZIK9yolWkzDkQ15rhanZJEvAZpB+SczbpYZ
         q2YE0Udls9Mr5vdIEuSw9hD2Gxe5vmZtMKjulJu8Vvwwh30KwUZa5fJYXhA29GVwGGUw
         bLQWlUi6DGqF0sSKD5Qd6yoNoj+rY6GGnALuDJ8yTGKIms4S7n9MDBCSvoJLtRW9bg6D
         1Uww==
X-Forwarded-Encrypted: i=1; AJvYcCX7qIbv/st3NeIJsJdmdbLupIsE3GlN5mBbIVRxKpuCsZkM/3QDy1LwHX6b6D+5O+55iX+JTNEzKSKOj2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUkWdRtR9BzePU0P/lSmRPj7+G2n7ohZ87RVFivrPmiMIYVjD
	L1c9IDWTnp0VtpBeBgBTzrjblZ2pwSrOB2EGHEWsXrYSuBY/g4kuoha+e6uDgryJ8IUQ3aszwrK
	e4kX89HOOvFHKZ6QwwKBkkqE6U3ZHN87+UscwzedrY3TTk7PZgmnVmi8lnAFmmE026KSA0jVB86
	+NlYlXwEfLc8fDC2Ii9+vAjZ2oUnlWuXgfYRNTmIh1r7ch3FFv3KeQbpbS1T3c5hFy+A==
X-Gm-Gg: ASbGncvEUAfSzsVqOMdUaPbgRhHEALkm6ilhy4fwAyYCoyaq82gGCr8eORxXBdg8OZT
	CjTZequhaNTTgB6eydv/w/r0m6ML8KTTsSdWN7aP02TnPxpyxYPMW0wnpKmK1LkKuzC0WPN1Hht
	KSAg6t9AgCs4qsEn1j
X-Received: by 2002:a17:907:e841:b0:ac3:c7c6:3c97 with SMTP id a640c23a62f3a-ac3c7c63e02mr312151966b.0.1742439004259;
        Wed, 19 Mar 2025 19:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwS+F32m6Dcu78HgQNZGqxJlY3fybv+AmFOl0HtP3didoMbVm/KSAg3G+rEAHFJesanYJAO0wJ6h7PYuGw58=
X-Received: by 2002:a17:907:e841:b0:ac3:c7c6:3c97 with SMTP id
 a640c23a62f3a-ac3c7c63e02mr312150166b.0.1742439003877; Wed, 19 Mar 2025
 19:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 20 Mar 2025 10:49:52 +0800
X-Gm-Features: AQ5f1JqrpuKUwPyaCxlP-DpgVkJ4Rtp6uFAR420KNM7iPB4x68hQryVObfFPATM
Message-ID: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
Subject: Regression found in memory stress test with stress-ng
To: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, 
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, yangerkun@huawei.com, houtao1@huawei.com, 
	yukuai3@huawei.com, libaokun1@huawei.com, Dirk Su <dirk.su@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

We have found a regression while doing a memory stress test using
stress-ng with the following command
   sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0

This issue occurs on recent kernel versions, and we have found that
the following commit leads to the issue
   4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")

Before reverting the commit directly, I wonder if we can identify the
issue and implement a solution quickly.
Currently, I'm unable to provide logs, as the system becomes
unresponsive during testing. If you have any idea to capture logs,
please let me know, I'm willing to help.

Best regards,
AceLan Kao.

