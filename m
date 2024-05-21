Return-Path: <linux-kernel+bounces-185435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAAC8CB4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD7928532E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3FD149DFC;
	Tue, 21 May 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bGOtEg9z"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED81494B9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324547; cv=none; b=bxWb5gdl167CLKnRGtVjbrfSThI4tBdY+Z6uwCmkk/5uWSZU8vaLBDzphTaB8HkuJjuaI0g5btDngutZh1p/9kKe7wb+65jZhjOnFj88n03xQertn0NeHsQ3wsRLWXMDzMieSD5W9mPOzG2t2gPI2joi2l60oTgoRCIQ1NLHCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324547; c=relaxed/simple;
	bh=693jQWAREfUdV/HbHgjOUtkEmsrn6/m+v+a7zyIHVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUbF+rSvDTx94Z9Lam9vPfLysqshzXrg/hNsHi/SbjyksJq5QjaRyuB2Kmcf+0JJRU1DJO7NFRk88v40NpKWMccw3AD3zKMytahCOXrYUjNNqQoqy6iNzv8ExncfFpuyLgWfaMsGruftVub6/uo7YDYAle/rrILpaUbVdAAExZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bGOtEg9z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-65c5a29f7f0so1764839a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716324545; x=1716929345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=bGOtEg9ziXoNqwXkpqdc4PZ9a/dAbvsOdVOv6Ku83BXj1uzMRgUexqjLybC6vjdwuF
         vyl5BeGOLjczKNcCkP/tIjHejxsaGNV1t1mptXMu8OHmNVQUVRr1aFPnnrhS+z7u9rSi
         TyEsregyM6IsQNW8QbmTkWsVfnJ3mZnyqD95NnLJ649AXvr958c52PadJUiNq6PoD9aX
         5LE815kSLpBWQ9xLvQSEDW9VCUFIgrYXOiFuQ4+2lTiTvo81nZFHYjvdMVPDT7ZwcZb8
         mHVe/kOcJg60Ee14FH4DclNTU8v481dskopZPkQVXtpuo2pu6aNhYA05mXo3veNx73Y9
         WMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324545; x=1716929345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=cL3dcWtXinD4ffDKOgPYJsozbhEgPVIqVh3JLFKUa9EKhWVZLx1/FVLyMWA66CGibO
         VdWR6mdNmJJMEOGMrGllNs3Csb9C6M1OJ2rcgNkDWk9DstcSJlLhD3vbVH62qWjWmRgu
         Vdsy38RrXodblsVM3ERLKBt652DA3ktu54kYlnTiE3Jb3Bm5vsrCiIV49bf8964J0cvQ
         iKnNu5xgFsGoWOORdQxlX6N4ebjbYazTg5nBxmP+DSnwz8Br8nLZFJVBSzKq9hqqhiQO
         R/KBJUPYyqcn30djAgoHuqfgL8KtxdNyBux15Oz+krNJUJVsemMLF79je7w4vWb5wUHJ
         fa4w==
X-Forwarded-Encrypted: i=1; AJvYcCXfusYsFY9SGyWbDuZavI7b8b2+ySWjxL1T+KDPt/4MkPsQ9EG8x0q1/ImiDX/l/IESFpHQaucx+YNIgVhu+w26AM+KuuguDlLDTo2Z
X-Gm-Message-State: AOJu0YzX8sW9vgCz+FV2scAOfU6rB7pbjiAjgViipX+dAAqODC5EYYkI
	YeOEVBXsAlEhW/BFAoao1pXIBCZ9xVUrpc4K1a7qJVOA5wm/ObEzmHtVDsVo76k=
X-Google-Smtp-Source: AGHT+IHlwL8HnlxOnwn8kJ0fVFV55sB/RolsKAbelV78JZZEngYsdS/7UN3t2OKQs87EBwQocJT9nA==
X-Received: by 2002:a17:903:8c6:b0:1dd:bf6a:2b97 with SMTP id d9443c01a7336-1f31ca37710mr787045ad.60.1716324544792;
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958d1e3csm114310545ad.191.2024.05.21.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Date: Tue, 21 May 2024 13:49:01 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
Message-ID: <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>

On Tue, May 21, 2024 at 12:48:16PM +0200, Jiri Olsa wrote:
>hi,
>as part of the effort on speeding up the uprobes [0] coming with
>return uprobe optimization by using syscall instead of the trap
>on the uretprobe trampoline.

I understand this provides an optimization on x86. I believe primary reason
is syscall is straight-line microcode and short sequence while trap delivery
still does all the GDT / IDT and segmentation checks and it makes delivery
of the trap slow.

So doing syscall improves that. Although it seems x86 is going to get rid of 
that as part of FRED [1, 2]. And linux kernel support for FRED is already upstream [2].
So I am imagining x86 hardware already exists with FRED support.

On other architectures, I believe trap delivery for breakpoint instruction
is same as syscall instruction.

Given that x86 trap delivery is pretty much going following the suit here and
intend to make trap delivery cost similar to syscall delivery.

Sorry for being buzzkill here but ...
Is it worth introducing this syscall which otherwise has no use on other arches
and x86 (and x86 kernel) has already taken steps to match trap delivery latency with
syscall latency would have similar cost?

Did you do any study of this on FRED enabled x86 CPUs?

[1] - https://www.intel.com/content/www/us/en/content-details/780121/flexible-return-and-event-delivery-fred-specification.html
[2] - https://docs.kernel.org/arch/x86/x86_64/fred.html

>
>The speed up depends on instruction type that uprobe is installed
>and depends on specific HW type, please check patch 1 for details.
>

