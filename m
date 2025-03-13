Return-Path: <linux-kernel+bounces-559841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D0A5FA83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DD21896711
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C330268C76;
	Thu, 13 Mar 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S43Pzg8m"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819913AA2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881430; cv=none; b=VmiNEeHa9KP+J1k8M56DKo8izNobIBkrgZ9FhCQiNguOTnffqPZoa5FSeOpjqf0NizXZ2VkEqnlEA+Onh6aQzGFysIwGlXXAEgFdguMhhyg5DEpxvoNm5cMmFWbxatVmGRrzZZoiGkUXERrvB+g3bASdNfvbLSW/4LCzQZMv2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881430; c=relaxed/simple;
	bh=lkSuz/k4u260/GNMuMFz0ZA0KwCIZ0YPnJRkJF7Uh/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiJbGoH2Lnlq2LKVjYfmlQZsTLMqk8BNU6GxYoJcTM2aSJ+N0QLwS47egglPJV+37MwOVpbXIeFKlYsuH+Br3FUyfJjgC03D5kKN42XAxEymSkz54P3vEUGyF2V4PBnxkruvMs3chVe052H+eUF0aO1kI/ZXsQzEHVli9Ktnvk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S43Pzg8m; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff37565232so5848397b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881428; x=1742486228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBmyDKUpiommKIGSKMzZOKB9b9qGKMc0bJ8kfU2qbbg=;
        b=S43Pzg8m6ycO/J3dvpteU2nuI6mSdfb//pSblBeMmlCXVdVJBzc+GaV9kDxpOm+mYN
         mHn/kI4ZE5WMURVTCSTyM6GGumaz+GPsD0DN7DGhBR4y/MzXg0MhBmroa95WNeQjjEXr
         JvxmhtNfxqNtvS3dlj0rX5SQd1Ac3MNaqTmINOULsEWL28nX5vPPXDjUL7AZUP10aXe5
         5KTuvlyq2HHXZFO3Q3NcMLrU09RwjEobXAf7qkF2AjVi6FaZF5vYMPMBkjK6u23K8WKB
         zHOZUdD3Y1BWFSxXTL2Lt2RE1vbLPlchu2Z8poiRfwaqAFBYMASzkD8F5Ybty5qxGPN1
         ZZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881428; x=1742486228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBmyDKUpiommKIGSKMzZOKB9b9qGKMc0bJ8kfU2qbbg=;
        b=Ch3h/Tys2gAoKHxu6zbdMI+imQMhiKh0Om2mNw+OA+8EzUk/T6oUrvm9qOTYR85oPR
         hPg5tDwmnvVCj7hxwN8Ub1t3isIowC3VE7N7LvGmu45YEUpkYXO9VyIWqXhNu+AiWc6Z
         Jwbl/ZwuBIvA9xrxUuPFusKFi/TDadbzxXZQeXxf23Mrpl0U7SNBX8DFFJCAgfyuNjCK
         rQGwpYVWmERHgMNZpDv3nN8dL7+wPdGhUyIWrvD+ataLm+PZjoQhHwQBzPRpCcEz+Up3
         H5FC2Wn3zcv94DiE4+lyLxK8XdQSdB/b3kxErtGx03hJYrWnj+onumwucIMqy9exw6ST
         u8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAWDq70uM0sZ18dWNm+nnFQtVVhoSpSmOv4aCO2sd85f0j96I9TDV/MYSqZYILtb3jD26bzqQstEQR6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQocSwvNO5tnsTT90bpj6fo4q2YLnfhNEBNS0cPMgftlLXYYZ
	G1LqqORpu1YX6GvnSzIv4y4GzUXm2OO3ZcPOagFTuMFfE2cFonxa
X-Gm-Gg: ASbGncszpoJCCBCGjqrc4h7UeC/oyIDSevBShBkE60ZOjW12TBLHnGOeslL8nN4MMov
	639ebJBgNmbOmsMPR9TmB6RdGrIdEVAJ8lRHlkD4LvqLfJNE002IiuilY+a0iqTFRahbW23MXqL
	fUAjOysL8yWUSln5+IbIm21UI6b/Iy92XBuJFSQDsgY7YUjEYhec5cAoHGkRDRaLzLVjGd7KsdA
	rb8UcPpwbexRHL3rS0P/hYcBznRghVVIMaiU+Or5SFil6ZvMBqFsGqnU7fVyzOErcGfvtXjDuyr
	h3mmAbDB44l+Ha6TAZ92v+4/xx+kqJdl8JcAC82ggvk=
X-Google-Smtp-Source: AGHT+IFxyQ9wNWdzuK7lTh0XEvFD/n9auheeFjnwpeBULqjgsHi1P64eAWAsA7fFVJQvuALPUUaprQ==
X-Received: by 2002:a05:690c:c92:b0:6fb:a4e6:7d52 with SMTP id 00721157ae682-6ff092928b5mr181604867b3.35.1741881428160;
        Thu, 13 Mar 2025 08:57:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32874fc2sm4065987b3.45.2025.03.13.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:57:07 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com,
	kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Weighted interleave auto-tuning
Date: Thu, 13 Mar 2025 08:57:04 -0700
Message-ID: <20250313155705.1943522-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109185048.28587-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  9 Jan 2025 13:50:48 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Hello everyone, I hope everyone has had a great start to 2025!
> 
> Recently, I have been working on a patch series [1] with
> Gregory Price <gourry@gourry.net> that provides new default interleave
> weights, along with dynamic re-weighting on hotplug events and a series
> of UAPIs that allow users to configure how they want the defaults to behave.
> 
> In introducing these new defaults, discussions have opened up in the
> community regarding how best to create a UAPI that can provide
> coherent and transparent interactions for the user. In particular, consider
> this scenario: when a hotplug event happens and a node comes online
> with new bandwidth information (and therefore changing the bandwidth
> distributions across the system), should user-set weights be overwritten
> to reflect the new distributions? If so, how can we justify overwriting
> user-set values in a sysfs interface? If not, how will users manually
> adjust the node weights to the optimal weight?
> 
> I would like to revisit some of the design choices made for this patch,
> including how the defaults were derived, and open the conversation to
> hear what the community believes is a reasonable way to allow users to
> tune weighted interleave weights. More broadly, I hope to get gather
> community insight on how they use weighted interleave, and do my best to
> reflect those workflows in the patch.

Weighted interleave has since moved onto v7 [1], and a v8 is currently being
drafted. Through feedback from reviewers, we have landed on a coherent UAPI
that gives users two options: auto mode, which leaves all weight calculation
decisions to the system, and manual mode, which leaves weighted interleave
the same as it is without the patch.

Given that the patch's functionality is mostly concrete and that the questions
I hoped to raise during this slot were answered via patch feedback, I hope to
ask another question during the talk:

Should the system dynamically change what metrics it uses to weight the nodes,
based on what bottlenecks the system is currently facing?

In the patch, min(read_bandwidth, write_bandwidth) is used as the heuristic
to determine what a node's weight should be. However, what if the system is
not bottlenecked by bandwidth, but by latency? A system could also be
bottlenecked by read bandwidth, but not by write bandwidth.

Consider a scenario where a system has many memory nodes with varying
latencies and bandwidths. When the system is not bottlenecked by bandwidth,
it might prefer to allocate memory from nodes with lower latency. Once the
system starts feeling pressured by bandwidth, the weights for high bandwidth
(but also high latency) nodes would slowly increase to alleviate pressure
from the system. Once the system is back in a manageable state, weights for
low latency nodes would start increasing again. Users would not have to be
aware of any of this -- they would just see the system take control of the
weight changes as the system's needs continue to change.

This proposal also has some concerns that need to be addressed:
- How reactive should the system be, and how aggressively should it tune the
  weights? We don't want the system to overreact to short spikes in pressure.
- Does dynamic weight adjusting lead to pages being "misplaced"? Should those
  "misplaced" pages be migrated? (probably not)
- Does this need to be in the kernel? A userspace daemon that monitors kernel
  metrics has the ability to make the changes (via the nodeN interfaces).

Thoughts & comments are appreciated! Thank you, and have a great day!
Joshua

[1] https://lore.kernel.org/all/20250305200506.2529583-1-joshua.hahnjy@gmail.com/

Sent using hkml (https://github.com/sjp38/hackermail)


