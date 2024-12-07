Return-Path: <linux-kernel+bounces-436053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF919E8084
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776F7281D5C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE4314A095;
	Sat,  7 Dec 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKVF/a1M"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353422C6FE;
	Sat,  7 Dec 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587634; cv=none; b=mAkqS+WE7ApjRf9Yf5e7fi85csntMz4LSNKEspDlP9zcBP1le0LodiDrXVXyAJyIMe70NaoqJIJceON+kUIUldM8GgbJZ02xCVorBvluepZHjSwtaAEhgB953zkvo3beaXn2T5sVKcW2VFvLZwNo8wH5kwXEnlU5t6qjywrdA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587634; c=relaxed/simple;
	bh=M+PTMrxiViwzOgLRhLrAI6GS8S+3PjsEetlUe/HJIIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o66gr6o/dpwV+GHXEWSrNJD+DHI4WOo8fDrHUBuqiHYvSYzXZDZrneV5d6Hwu3CJD7gGi60fcnTLHJuFwGXtFhLp32qkiGXRxCSIslNvkmIpZLIrJ2HPdweCwD7fYYrZLCtPVH7K7gCg1RoBPqqXxJ//QKfj01APBY/bbAzcToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKVF/a1M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7251331e756so3318694b3a.3;
        Sat, 07 Dec 2024 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733587633; x=1734192433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g859wMeIF9KNYMteuI4kyvHlQIAJnovF7UVR8hZbt9I=;
        b=DKVF/a1M6JU19PSSOKsnx2wudoHMOOoB8CNGYl/KQYJTZZ5vWb52VTVKvLJuPy1p9F
         UE9Zq4X/GLryw+Z52sRT8suQL5+b1R+WW9Cq8Pwo5fNcJbTzonfd/y9ZK/13ufQV63qi
         LHdunsb+zqmNTl+K/1HxPMq+ftEm9frD6ax+VNKh9mSK2Rsa8H0q7TVr78GTkdIAFciO
         9VawMkRuco0H0QLsX760NGEDOF8TPN5sEotAVjtfSaph386zc2RCdpsRaUecU6QMKl5Z
         6fm3xHzPxRgeBnzhIU4nrggpFTW7ABwxw17FLzb3EBY0/YM8AP/53INGRTCgt59xmBcx
         k8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733587633; x=1734192433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g859wMeIF9KNYMteuI4kyvHlQIAJnovF7UVR8hZbt9I=;
        b=ETD7yfjD28R9ig9bRtIVMNzhHz7A5JvhFNfV0mTZ0xGMzO/MANAyXysCARMxPbavyr
         ol/2vgr+tcKF29+zzZcgxWvlVz+1h8eeJ9jurRhQowyn+wN49WIFjqQF3JjXXt4+P25b
         5X6DQ93EHbdnvbJGOs3uvebW2m1wVivn/XtbLxoKzBZXSPD6vaHrqDz0mhKcWnFOclpq
         xWALWAubuBaXpejHDqoqjAlAL2S93HCXAMUInehpBsK0Scg7S62tdvv0+FHO30dCYwFl
         q1qod6mVZaQJBIU89HU2JLLnqZciew1TK3WvoinHeNBM4oRZWDEw2GZOX2vlLCW5uzwI
         VWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVID9SGMBafT4bl+m97KfdKsMaiQ4rqQIT/lnaRh9gCIaU7YwCbEqBBETgXifwlq77qzOhfgQfqfo3/V6WDpbo=@vger.kernel.org, AJvYcCVuciEjWrMdAqRxAv1nBJPqk3nHx38Gr747klLQteNC3SXLrKqENHXV3Lg/bX82X+apTaHGhCUzfbWQdEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ349t3vkUrik74/9yEOsebyuidh+RebJ8eQM+y7rAdasNM+mF
	YSN8ga/wRmMDDYwQL7+LXS6llxywWeYz2SmbHsEE6QnUfLmE1Au3
X-Gm-Gg: ASbGncsBbkkX0k2xUHOCDKenB/DpEpjPpMTZeidnAzuD2PQAhNF1xlmXpM5KTSX3bR9
	HuDSyLJKa+s2HW1CA6QJMCDQKV1jNcsZAH+8K7+CqHCqrsc0DQyH4XLnS7ck5+DUX5kHlJo23V0
	2/u8bHxVUWe8wKrFvtDnBIUrX3UlwFHIz9quWojco5bz638Vk3yCt9kUMpbWiLAin8GgIEWkO6i
	n19LfbsXWrL1c63MJLkiOSfoKj5kCl/+gphEYQD1/cO7liQUd+QbFaO
X-Google-Smtp-Source: AGHT+IGynfywcTLLgMC4Efclc9q2iwS5FtGtPBFCfNKfQzfsqrE2qYlYchQ1vQzyQbVT5cbqIzv2lg==
X-Received: by 2002:a05:6a00:4f81:b0:725:8b00:167e with SMTP id d2e1a72fcca58-725b8177ed5mr11222451b3a.16.1733587632683;
        Sat, 07 Dec 2024 08:07:12 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e2388d37sm82627b3a.73.2024.12.07.08.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 08:07:12 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: daniel@sedlak.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tahbertschinger@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com,
	wcampbell1995@gmail.com
Subject: Re: [PATCH] rust: macros: add authors
Date: Sat,  7 Dec 2024 13:07:03 -0300
Message-Id: <20241207160703.55846-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
References: <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Daniel Sedlak <daniel@sedlak.dev> wrote:
> Since module is a macro, if we would allow syntax in the macro like:
> 
> 	authors: ["author1", "author2", ...]
> 
> I think we could fight with the code formatting, because when it comes 
> to the rust macros, rustfmt is often very confused and we could end up 
> with variations like:
> 
> 	authors: ["author1", "author2",
> 			"author3"]
> 
> or
> 
> 	authors: [
> 		   "author1",
> 		   "author2",
> 		  ]
> 
> and rustfmt would be totally ok with both of them.
It seems to me that the rustfmt.toml in the kernel, don't have a max width for
line. Are you sure that the rustfmt would broke the line for big enough lines?

> I think accepting several "author" fields is the best one because it 
> mirrors the C API, where in C when you want to specify more authors you 
> just repeat the MODULE_AUTHOR("author<N>") macro.
If you (daniel and miguel) are ok with repeat the `author` field and think that
this is the better option I is happy to make this change. 

I was run the follow command:
grep -rwo 'MODULE_AUTHOR' . | awk -F: '{count[$1]++} END {for (file in count) if (count[file] > 1) print file, count[file]}' | sort -k2 -n > res
for found the modules with more than one MODULE_AUTHOR.
I see that the maximum of MODULE_AUTHOR that is contains in a module is 11. The
marjority have 2 MODULE_AUTHOR. Maybe, repeat the `author` field, is don't a
bad idea.

Thoughs?

