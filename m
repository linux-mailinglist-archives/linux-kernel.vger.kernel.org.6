Return-Path: <linux-kernel+bounces-541039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEFA4B7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B821890AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8681E22FA;
	Mon,  3 Mar 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGgSwXB5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845AEADC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980778; cv=none; b=oiq+o76+twxa8jRuNkXvas7SiQM8lFYwlpgLExNQFG6TDokd2jCVeikWvL+jTYJUhEudaSjnU/GSxlEOuywzVnLf5tUAxt3PCKi8S83Yd8rPIEDLSBnhnFEoE7Awb6ngZriYdCiGGpwkwPVA4ululBT2s5AuDufZIqHlnYb0pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980778; c=relaxed/simple;
	bh=kFywK/ACq8d8QY2b87w30M3VzLAGE4vSEdG8FS6u2Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdtlZEzcnEi5lQ5KF5sXC1gXYruwXN6ovt6TrBEQ3IlmMf7FifemaQGOQ2l+hjaoa9iXp+DadXCQV4Qa7UYiTz19+w+nlT8kVBEG5bTqXmXzfCVcYyJTMIPvvpmikRK0kdwNqclEyGlkj/49wyQ7SOW5QYmXdYG/I1xY+tpONaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGgSwXB5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a0da61easo124315ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980777; x=1741585577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWZczVLGJa1y4XReahdUAMxIiZ2gtlx/faB4w9x6vag=;
        b=yGgSwXB5hM3gv3yGEdhsTm0mRnqprQl2Aw7dv1Ghq8tNIef9S0bGq//SGA6NdX19KC
         MrGgFGAOVZalwoM8dwy/0cHBzE8Y/glcCLvEnrf2a9KOfdVWMXnjzRaMTcAESKoiZVG/
         l4rdLAZPwvEx4inICpx9hgDE80s5urDx669foXqSc8xLBCN1xyAkFWhOrJkthwFguyDW
         m5FPnneZfKNEVHoi4iqhBnuS3zDzrLHMEx4KKkDGg6cIQhvEmoNL5PdhFx8oSclbT6o0
         IOypmY/WHBNDRZCwfdA7h9xrljhZKLxkPl+YL0gZkFDe1rCcB6wtx/LvvkGNkyTz95B2
         CFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980777; x=1741585577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWZczVLGJa1y4XReahdUAMxIiZ2gtlx/faB4w9x6vag=;
        b=fhl5tsOv62XpLE17Ud6fIcXyyZfpKrflomW5w8AzNbZ61zxO7QHmv8EezWc1i6NNzR
         TbsWBRp6FNPwydLBdR55x3ix2EFLRaqDoKipdN5Tc9IbJpf74prBy5siqwif5S8ieZ7n
         zbAxS1Wizp4s3vARgSkLWKqPe4Ypj2xvYn8lRmFaFqwgzKciDjerXSe3yM3SQg5wkrxU
         ctB/H0dHgIveYaWYnc4rjWiDHJGoe0Sg2yWkkbylpfs61AiISnZ7z45JVGRm0ROmdxq7
         9gRBIGv1lkRBxEn/lzJVpI4avVpwrCF6hRQY/otRGFjEpKV3Svn73HN0l2ptdq9oOcym
         qQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhJE9sHOyj2eJoXJGSlksq/H2/4OdARAV6kCOscH9TcjEvWgIFxwqqSWtIBZfmZNu1knTA7ra2HC/fZ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEFkD6mxzbeeG1q+NVj758hrq/NkmcIpXDrszT5V79glFQlWt
	5+dh7cwo/kDxlvadM7s74Yaxh/Rofek8fGEbembSdCep0hrhJYwJxdLClJbkCw==
X-Gm-Gg: ASbGncuuPseEogAyzDEiwSk34WYQzdPBFxN0w/SYek/uHnEYNCqx+4hDLY7u1agV1BO
	OVJCV+4OfH18Kfagu5YRJPWOXUxOKNc34lV8csMlAHE9PKNp7RyjBlwAKSHW64+pHtKjhQww826
	4kLXfuhns7X8k0QBpKuGuf7DmMiDNfDhNkt6BcGW9EtFtxd8YX+7jQIZd8jlGjlvMXT3lW5KiB4
	wmw7JvJRvvC00jh5Mjtmdevc9LnwKOFv9UaN4dH0kt7R8v5c4RT8nqXlDdsIAhUixIp83Ahl4e5
	UEImpCGGqt7yK9w8ZMcTIvma52ZIrCIwsdyYew23W5wlySKbVvcwo+8OqVaz8KLs2svJLrq7H+7
	uk+SM2bg=
X-Google-Smtp-Source: AGHT+IGR9sIbs4GODDlDVazb4ZHmmL3k8nYNXhdZXtHYDL05wSLBQV8yxY07hQVWXU5lra6HhADNPw==
X-Received: by 2002:a17:902:c947:b0:21f:56e5:daee with SMTP id d9443c01a7336-223826bd593mr2964695ad.6.1740980776552;
        Sun, 02 Mar 2025 21:46:16 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024c04sm8210373b3a.105.2025.03.02.21.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:46:16 -0800 (PST)
Date: Mon, 3 Mar 2025 05:46:10 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>
Cc: bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 08/10] bpf, x86: Support load-acquire and
 store-release instructions
Message-ID: <Z8VCIrnJ10uBj0yN@google.com>
References: <cover.1740978603.git.yepeilin@google.com>
 <ea2754510513dce17a1d8f4fcab07d9d769e7b08.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2754510513dce17a1d8f4fcab07d9d769e7b08.1740978603.git.yepeilin@google.com>

Hi Alexei,

On Mon, Mar 03, 2025 at 05:38:07AM +0000, Peilin Ye wrote:
> Recently we introduced BPF load-acquire (BPF_LOAD_ACQ) and store-release
> (BPF_STORE_REL) instructions.  For x86-64, simply implement them as
> regular BPF_LDX/BPF_STX loads and stores.  The verifier always rejects
> misaligned load-acquires/store-releases (even if BPF_F_ANY_ALIGNMENT is
> set), so emitted MOV* instructions are guaranteed to be atomic.
> 
> Arena accesses are supported.  8- and 16-bit load-acquires are
> zero-extending (i.e., MOVZBQ, MOVZWQ).
> 
> Rename emit_atomic{,_index}() to emit_atomic_rmw{,_index}() to make it
> clear that they only handle read-modify-write atomics, and extend their
> @atomic_op parameter from u8 to u32, since we are starting to use more
> than the lowest 8 bits of the 'imm' field.

For x86-64, v4 PATCH 08/10 implements ld_acq/st_rel as regular LDX/STX
(aligned) loads/stores.  Please take another look.  Thanks!

Peilin Ye


