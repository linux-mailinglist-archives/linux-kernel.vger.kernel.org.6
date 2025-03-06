Return-Path: <linux-kernel+bounces-549172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27850A54E87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614D41894E30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D12E634;
	Thu,  6 Mar 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NvgHTTU2"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE6188A3A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273514; cv=none; b=pfQObR/cp1ikTz6/2XxVZNjvtxwxsueqbI0xTP5B65Vkt8tIT6gnl5tVs7RwP7WZs5ru7DJOuQkd4OpwJLVT2Q8/SHKoxDcqJT3m8aLfMldT39wSDF5GxsNI3WbjZ2qaAimdRg+TJEUaNRIh+gJ9VxAh/k3x9m/xCgFT68qmB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273514; c=relaxed/simple;
	bh=TK7VGJ9wAuiaUqk6rSlvDmS9VC/uE/WDIOEUN3K8tI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PtNyK7ftgO15m8F1t4+5Oc8UGG//UOJfAk8z0httpGNrk1a41Ug5HH2+YbxyzNpwCbfwb+btYDDge2tmFP9/4+ai70+aqFlpudqx4Xw1qWbx8OgrprHreK20wZ+w8ktdWEiLmv+FoHYvurhb9pjkX/1oXvoNgUV/lllMytzEk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NvgHTTU2; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ae65ba2f1so19974539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741273511; x=1741878311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mxhfe662mFKXoNMPrYea9QmFeK+eqDDltOasYkoZcA=;
        b=NvgHTTU2TllHBEQWB2pvDA/nfQKDVLudgEdr0YEBWbOa1T6vXQ7rR1iOv3mQfPrfJH
         B1aqThg3vk/KJp9QpV7acjALcfdhJ06C3hnXRMIlf5d6BueokYIQT4O0ce2hyMZm4UPi
         ua+dMMX8rMpepOyzjj5ccMSLPVcw7ZJdAHzpPXRZGzDUg3WLdJLQtYWuQZ2YQRqYfxs0
         g5vc2I3+UKMBsBwaaHUlf7mqC2dtTTQf1Y2Vqc6+ogJF4RJy2E+LmZ1u+sBpvh+FriTb
         Gz3C8qLsd7EPk2mWWF/VbHbH7c2hYy2vk7WSyJn3mg7ttzxchc8xxs/vr3yNhP4IqDeW
         0xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273511; x=1741878311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mxhfe662mFKXoNMPrYea9QmFeK+eqDDltOasYkoZcA=;
        b=FdYNZbt2rh4ehQdiZIRR0lXAKyR03wyL0LjNify8lvWYvPX/EUxGrjtPpj04yFn/sF
         +DZM0UiP09J8F75cj0Uz4yV2iULA5kAdADPlm8vDrFn5xkix/dmRF4f31e8gAX7i1m/q
         ikMCm2oOhwHE6NPFuxROdgF6NtaULxCluHzBcrFdK8v9XOUL60tSCTMgj6rUpvF++Nvm
         JKcSAwW0BfjZTs8rFR/cmKsWyY8e8pzinTrdeKyxjnJbrempXJEHzBCD5gUZIHyvuVqk
         wUEM8vhk72LZF2d7VkcbnZAngE2Lu/7PGt4qQA4O4YAy4iePvFRPRQhk/YG19hd/OlUT
         ARLg==
X-Forwarded-Encrypted: i=1; AJvYcCUAE9vpE9UG0kmxcWl5o5p2PLi20jRyBuR3x7B5H01rZnpUIwYW31ovkqyYMyrrXSJlU9qo6oW8hcdmi7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/sDsyIhksBSuePbFf7FNbG1lAdo4k93WFd18/jMbkhKAmMTc
	gtTM98qsQsGP9kehZauGwM26OnZzqMCuP+Zgwnr4VTAaGfpWK7E07DtgedzAMrs=
X-Gm-Gg: ASbGnct32HRitpZxOBDFsZO35cxJpkrCuyPKGEhC+7OFD2cev54NNGm9MvhRVxSgQut
	CP3bkwRvr0/Oe9WA+LNop5iXEVdYP0uQTrus+b18zspSIFVTMBkL7w1mqZ0GW6zmTsiYv/DR7Sv
	IyaJTPJAy/gFKMOUYWIF0CA0aSmUgkY0cJ7KR0zEeubNTBgaPIqhV1BodspA+4szJGQT9vvFGZ8
	gD0amO9CvYI9eTA6+2GjbSobgHR09JfVUq7l/AJMOXTRrrBAnYontkGAQA9BQMnn06Ty8ddTixT
	9NmPH+/YllLpARnZAKwVUd79jYXT5J/nRzuu
X-Google-Smtp-Source: AGHT+IEqAuXd7afnd0Dt1HKumrunpDNZSQhc5PKX/Hjsq7JDKDGmQ5oF9rxSxlYeY9IOKZII3LXW2Q==
X-Received: by 2002:a05:6602:36c5:b0:85a:f63f:cf06 with SMTP id ca18e2360f4ac-85affb58d03mr901346839f.11.1741273510171;
        Thu, 06 Mar 2025 07:05:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b11986819sm29718039f.6.2025.03.06.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:05:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai3@huawei.com, dan.j.williams@intel.com, 
 vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
 dlemoal@kernel.org, kch@nvidia.com, yanjun.zhu@linux.dev, hare@suse.de, 
 zhengqixing@huawei.com, colyli@kernel.org, geliang@kernel.org, 
 xni@redhat.com, Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250227075507.151331-1-zhengqixing@huaweicloud.com>
References: <20250227075507.151331-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH V2 00/12] badblocks: bugfix and cleanup for badblocks
Message-Id: <174127350864.65950.963243812292712820.b4-ty@kernel.dk>
Date: Thu, 06 Mar 2025 08:05:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 27 Feb 2025 15:54:55 +0800, Zheng Qixing wrote:
> during RAID feature implementation testing, we found several bugs
> in badblocks.
> 
> This series contains bugfixes and cleanups for MD RAID badblocks
> handling code.
> 
> V2:
>         - patch 4: add a description of the issue
>         - patch 5: add comment of parital setting
>         - patch 6: add fix tag
>         - patch 10: two code style modifications
>         - patch 11: keep original functionality of rdev_clear_badblocks(),
>           functionality was incorrectly modified in V1.
> 	- patch 1-10 and patch 12 are reviewed by Yu Kuai
> 	  <yukuai3@huawei.com>
> 	- patch 1, 3, 5, 6, 8, 9, 10, 12 are acked by Coly Li
> 	  <colyli@kernel.org>
> 
> [...]

Applied, thanks!

[01/12] badblocks: Fix error shitf ops
        commit: 7d83c5d73c1a3c7b71ba70d0ad2ae66e7a0e7ace
[02/12] badblocks: factor out a helper try_adjacent_combine
        commit: 270b68fee9688428e0a98d4a2c3e6d4c434a84ba
[03/12] badblocks: attempt to merge adjacent badblocks during ack_all_badblocks
        commit: 32e9ad4d11f69949ff331e35a417871ee0d31d99
[04/12] badblocks: return error directly when setting badblocks exceeds 512
        commit: 28243dcd1f49cc8be398a1396d16a45527882ce5
[05/12] badblocks: return error if any badblock set fails
        commit: 7f500f0a59b1d7345a05ec4ae703babf34b7e470
[06/12] badblocks: fix the using of MAX_BADBLOCKS
        commit: 37446680dfbfbba7cbedd680047182f70a0b857b
[07/12] badblocks: try can_merge_front before overlap_front
        commit: 3a23d05f9c1abf8238fe48167ab5574062d1606e
[08/12] badblocks: fix merge issue when new badblocks align with pre+1
        commit: 9ec65dec634a752ab0a1203510ee190356e4cf1a
[09/12] badblocks: fix missing bad blocks on retry in _badblocks_check()
        commit: 5236f041fa6c81c71eabad44897e54a0d6d5bbf6
[10/12] badblocks: return boolean from badblocks_set() and badblocks_clear()
        commit: c8775aefba959cdfbaa25408a84d3dd15bbeb991
[11/12] md: improve return types of badblocks handling functions
        commit: 7e5102dd99f3ad1f981671ad5b4f24ac48c568ad
[12/12] badblocks: use sector_t instead of int to avoid truncation of badblocks length
        commit: d301f164c3fbff611bd71f57dfa553b9219f0f5e

Best regards,
-- 
Jens Axboe




