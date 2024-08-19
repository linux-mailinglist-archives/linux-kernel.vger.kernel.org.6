Return-Path: <linux-kernel+bounces-292920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA90957677
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEAF1C21F40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3215A86D;
	Mon, 19 Aug 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtjIWkUc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5C157E61
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102758; cv=none; b=IzdLUkNyt0CcsYWHXk8KhQ7reQI8dipuL30ak5psuK7TcUxWJ64pK5jXXDYZT0d913GJY8yTkxUo/CRLZfmpFqXt1K/mzR9mtvuW2x/5fz+u5AF8TbmDgvMqUSbbSK0Evs2p/SCEx0zb97Qw7crtOB6XxZP7iWORLToRf/C+Yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102758; c=relaxed/simple;
	bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cHYa2NpggJMlBLsJD/cnJOfRyXjngzE5cknXhLhNfbiFGJcOcxiXTfyFSS+/VmjL1NpqM1nHMgiXJCszLyRcfLVkh9tv7asQJyBMPakah6Cts/WOJoi8asgZYjqgC3VqBiORP7Boglxw1z6CUUJf9x3dwrYdcDFNG9I8AM+Mca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtjIWkUc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fae21398so27170265ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724102756; x=1724707556; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
        b=vtjIWkUcJxe5iJ8XGff3u3vuAaMB6UHXFFqq47j6dVtsCkRAAPfimY0eKVDAgcFVQu
         2o14GNCO1OED3kF/qbpxJCl4T8a4v9m2aJQhp3Sv2yqKUPGf7YwmYJ3rRQHQelBR2lwV
         CMhY4JE9902JunmGsYy8N1s6ZDzdPIEGIs/56z/SmC7WNS/q6sCkJMFDFoAFplEBUsVv
         fpYnUHJnXnOCO2dVbkGEAItYX8u3Ac3VNqUXshpTrb5/7B83I6w/W5+j08p171XNnQCh
         2I7wDgr7xVNUhLOBKqiKzmim8RQ0mRLO+hroVxSy4lFfMpnuAX7M9fh8k4TIPBo1/G2y
         +Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102756; x=1724707556;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
        b=JoLl6Fy6THZo0cY4GLcD1b9wnAE/j1x7VNhQJ1CauBUiTJvwYjDYIGIF0j4uwwgVh9
         2Psii0yE0wLhz8Kg7BxUIdjwdxJpAe02pRr6TQ1Rq7BybEL2uPxlldbeSMskJ1bwJzis
         McxC8WWq6aKGqPs41QYMlJFtOMJOsEYJAamTBDUKSipThzuj115v4cP3ddPqT7cUStqR
         1Z3DVHpcEP3WWuf92yrD4nT+t3EbjJ0hcnsYfyss/qL/ck7Xb6gVL4cjIkJNAwjpUHGg
         jfQsZU1AF1cQgjT7aaHT0kxA69i3Y5E3V/wzwW5w58OLR92EISw4/5Ma6XvIJrYjfL4V
         5npw==
X-Forwarded-Encrypted: i=1; AJvYcCVHmeKy785d2fENI5jz0NeuL31UeoZHANDmzRxh9hnf8rVvkS7wO+GI8b6Xii1D3fSia9Vkuk9C56z2ohI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFZqw8omqIOMVVzvLMxaMavBtfRaj6fnZA9ZSs9lL7W2BwrTo
	K1OeAU7F4eB0txXTDk5dIEwoTrwNlH9ogOzYI800dNM2+pA/SEwKx8YZTYs+NQ==
X-Google-Smtp-Source: AGHT+IFQHjn7opTqOCiNaxJXDmg60fElwtXeF7Mqy68b4YAgsiN5PqrB96o0Hinj5H+icTZoy+OWwg==
X-Received: by 2002:a17:902:f644:b0:202:51ca:9831 with SMTP id d9443c01a7336-20251ca9af9mr36829615ad.49.1724102755813;
        Mon, 19 Aug 2024 14:25:55 -0700 (PDT)
Received: from smtpclient.apple ([2620:0:1008:1:a1c9:254c:e95d:4199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375acasm66870965ad.161.2024.08.19.14.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:25:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: Qinkun Bao <qinkun@google.com>
In-Reply-To: <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
Date: Mon, 19 Aug 2024 14:25:15 -0700
Cc: Dan Williams <dan.j.williams@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 biao.lu@intel.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vishal Annapurve <vannapurve@google.com>,
 Chong Cai <chongc@google.com>,
 Dan Middleton <dan.middleton@intel.com>,
 Alex Crisan <alex.crisan@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DEAEC08-420C-46A9-8877-EBF60331A931@google.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
To: Samuel Ortiz <sameo@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)

A gentle ping on this email thread. We have tested the patch series [1] =
and will release a product based on the patch series.=20

If the patch series can not get upstreamed, the whole confidential =
computing community can not have a way to measure the workload with =
RTMRs. Without the patch, RTMR3 is completely unused. The patch works =
perfectly for our usage case (Like the existing TPM ABI, the raw =
measurement is taken instead of recording the log entry.). Assuming RTMR =
serves as an alternative to TPM-based measurement, migrating existing =
software to the RTMR could be greatly simplified by developing an ABI =
that resembles the TPM.

I don=E2=80=99t object to having an ABI to take the log entry. For our =
usage case, we use the Canonical event log [2] to measure the workload. =
I do think that we should NOT block the patch series for several months =
to solve an issue that TPM can not solve.=20

Link:
[1] =
https://lore.kernel.org/lkml/20240128212532.2754325-1-sameo@rivosinc.com/
[2] =
https://trustedcomputinggroup.org/resource/canonical-event-log-format/

