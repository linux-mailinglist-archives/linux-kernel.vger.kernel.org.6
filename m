Return-Path: <linux-kernel+bounces-245946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E192BBAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E341F22619
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368A15EFC8;
	Tue,  9 Jul 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0q3uGbD"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0F158D92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532835; cv=none; b=k+X8SC7RguGBpctvVjE08oJ6X+hdWsgMPgnWHOsy8vFDfGLBpHUCfN5ihIPKGPRgC2aE4bnd8rhC+eoz7aj9SXv6F2kgEhyvl5aTbFzWVBs0vb5FKnXuiC58xVxTkZPavVL43wA9ronaoiQPNoZ3i8sFFNxCvp6ztO9ipzosfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532835; c=relaxed/simple;
	bh=nSFfZbFd2BGFpO2PCYukKqAyfoTHr45MAIbU0YjCNiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFe8NkWi8B2oDN7QaTd0l+4NDY+Cj6fM+PkV1xPRibeZJ6kNIr7fbi0BB7rAC/yOmqGYb1ZJQV9NpMDj0lDKDTXUHVlmbXtxRvxtzAiBx7EhXOObjy4NTtkQ27G65pmS4z7clDRID2JzhGLFG2ibqyy6ou2Or3n2eXXsY6yidiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0q3uGbD; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447eefeeb92so11465531cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532833; x=1721137633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGIkGdkV4++eu2vnY9yilT0/UE+0DjFMMuz2Pn4/rzA=;
        b=O0q3uGbDVO/POATFHqKFOnBYipnWi3xrBFYdQpooKxBfMWl9NZxFQE2unsFMqpIjA8
         eEmZ1pn+XwSR6ugfMkkFRet6SKIQ0zbm+v8/HvQH0MMtycoA/suD5zX8DE49bypPqlr+
         YAZ87XEnWXRo2hYVor7qg0qKXISr6hC00m1+4oHSTjCyl/bOmEuMaR4FvR8USp1EWYMp
         jnewCngi5sQyPeYC7oZyLudZ5bdzP63JrPsAkCOuAql68doSnBN6dS//PKT+V8nXwzZD
         w2h8a7mpP1Rjy9gr5fLDdgOE2wisvun8O+N6xleSQXhicBBZb0aDQZI7Oi7Ar+cmcLY0
         ftFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532833; x=1721137633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGIkGdkV4++eu2vnY9yilT0/UE+0DjFMMuz2Pn4/rzA=;
        b=e375TMguPN1u4be3ZTdtcE1unGa7e44DLWSivg7Sn2psU/Lw/xkLYW/BYydfEQqNV3
         BpuraF5ZXpcB0EjJEKSFjNT2N2xFt5yzxw6qPddH8q7tmPFugL9hrPyDQYkLdJssOFNN
         dZDPRon9wr+B0pPC2w8xF1w+SHfFSvL6v3Oj1FSk2kvKAGSQeIcypNIrlszZVzAS+UMu
         qR6CR8BOBlomf3EHPBCLZxs+8jeje+ReIZegy/j5vAgcjh7V9peneIC+UQTlM6XTX/Dy
         i1MTfwS2WK2+/+AsGPbYcxs7Ue1Wh0h3kU+B0tlABsB3NSqQE6DPXS66NY9nyjifayFd
         Y/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqToeKZbGZgXz0Ni8aJwiDHLRT4HdZOQCJazTMkyk7RQSuWRyiowDEGRlEMhcRUeFvsY+AYSC8YKPcDHeutiGESPoqZWj380N7lc+5
X-Gm-Message-State: AOJu0YzOPAItye8kA//2OjlJNwLIZTE4zfs9Ld6OWpbtm9nI3lnMZClF
	dMsQQIxSFzhjdXgfu4M3ZD2AWlbBLDTF3uv+TqxNCA1plxeU/F9AY19qW5atDdcQ+/aqGMfAUej
	HCAhUpHnVnu02HOthS0zm1YVnz5N/QLU73N0RuA==
X-Google-Smtp-Source: AGHT+IGmoA0T88ljBnzqezS2HNtUpAzZ6Pl7miiM/qOWeZpUofmQ2dI94hIlzdSJknzxEm3/dd12u75cGCnd0agjHgU=
X-Received: by 2002:ac8:7f07:0:b0:447:f4f6:7a1 with SMTP id
 d75a77b69052e-447faaa57f2mr30672561cf.52.1720532833330; Tue, 09 Jul 2024
 06:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANtevs+a-ec45oz1tJd0m2Qc+dU4ASj9BcdUbyhsQ5Hm94dEKQ@mail.gmail.com>
In-Reply-To: <CANtevs+a-ec45oz1tJd0m2Qc+dU4ASj9BcdUbyhsQ5Hm94dEKQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jul 2024 15:47:00 +0200
Message-ID: <CAKfTPtBhd9f5V7VCYtuYH5gBe7x01dZkTYCQtvTJDDPpmoZpAw@mail.gmail.com>
Subject: Re: [PATCH] sched/autogroup: Improve readability and performance
To: Parker Stafford <parkerstafforddev@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, "rostedt@goodmis.org" <rostedt@goodmis.org>, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Parker,

You should have a look at the process for submitting patches:
 https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

Thanks,
Vincent

On Sun, 7 Jul 2024 at 00:21, Parker Stafford
<parkerstafforddev@gmail.com> wrote:
>
>  Hello,
>
>  This patch improves the readability and performance of the autogroup scheduling code. The changes include:
>
>  - Added detailed comments for better understanding.
>  - Optimized locking mechanisms to minimize contention.
>  - Improved error handling and provided more informative error messages.
>  - Avoided unnecessary memory allocations and deallocations.
>
>  The patch has been tested and shown to work as expected. Signed-off-by: Parker Stafford parkerstafforddev@gmail.com

