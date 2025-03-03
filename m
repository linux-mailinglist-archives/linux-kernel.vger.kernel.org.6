Return-Path: <linux-kernel+bounces-542776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C875A4CD84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585A1163380
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F94230277;
	Mon,  3 Mar 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gascq0cK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F010757EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037470; cv=none; b=kI7O03Pyh7/fJYBOL32oRc0siTRjdmrVO1S85aSjcJQ1vqV5hxDbdCuhEFMIBqpsC6o5JMaCFxBtUcf6Lo7/xoi+wHt6kvhsOzxx6JukmzpemH2jQqAFK/GSK0tDLZ13dV/qTal9ll0BL21jHUYOvMhFarchnKKdCaSe8amh7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037470; c=relaxed/simple;
	bh=9z7dd46ydYHoEHmVtzXVdbOvvioBO2J+2c8XPCboJlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQLv2XTFtgOAwmhARKLNPCnOav4BcP498B2hpJdWMAjESkYZdpVTPHjuBBTHXcPZV7xib/kAABpJO5yNWsVo1lNig7POmTfmN5khHhyz2Yl9lzW3XI9z2hvdZRq+hNWUIUKfu2827PRcUG7SoCL+rVV/+nNM/0hF8PzTleOPaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gascq0cK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2237a32c03aso13755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741037468; x=1741642268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f527JpJGgzYKHPF758VmJ7IyFpSx+9+vZbzdff4JDwU=;
        b=gascq0cKJW+T9xRfaG6PIeYSL+kIJh8+83ygKrhfatbUb9mKaG5sxSz7NImHXL0cI9
         N0ZySccyQKL30OIri+dKCp2lqleaP7LhSPztDhGSuwBDlm2PlTaE6nIC2fC2YT70K+j6
         qycaXX19dr0i3YbWAcgUX5vwvP/u6MSpAGVhyvdbKCR4mlJ1HeiaTcnwdPi9O2OTfoQh
         ZpgdVdSJrvVwPG2EBOho6yBJ0SgKPcpM/osq4H50XImOhU5/YLPoOH+15dt/P7KBi82t
         W9Wx56ZBj1L+YABDt1lGwpsH5o+r1LDtwlm3jTtbr5leGau3r80zoFd5GlO5P7Hi+KKS
         Meng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741037468; x=1741642268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f527JpJGgzYKHPF758VmJ7IyFpSx+9+vZbzdff4JDwU=;
        b=a8BFZD65FB4vNtm5K3wnIieHywa6ytopQYYWPdmoP9FnrTdoYwjMY+jNzfavY23lGf
         i9XBnZwDhaD8WgvmJUKuO6SRqKCj7ZxdhNJrWlPLeol17Sefu7e0zkpEsaptc8VtYkcU
         KTbGGeyHAnyyScRDwGmJzC1uBDGMPqOcX6knM2mJtdrtlkttrVNjdFWIRb8tejk2H9Be
         7KTddZcZwJf/4LjqidX1SMkNQdtswX3fx3blfnm6qlbvYnzwLmHr1txlUkGE4xGigEiS
         3CFm3FbE2r1OgLPkitDGej11MQlK2/EuWHaagWAKWuKVdccA7wsctHpWbgADasotiU90
         5HqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytr08squgV8ojgFUxv5rbxFeUW8gyZsMxxgbYTRDQ0Z1E+l5wW02gjOaNwNqzCLvMqpAUfts3eqQ01iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgHZvslxavUDRR5p56SIVh2iDz5pFeJgX3Nip8Irm1IRxPJvx
	2ru1ugAkuRjHzeN6thdNNrZCb8reSuY6OzxiL0AhMbREGtz+W9KGEriLAfZz8Q==
X-Gm-Gg: ASbGnctrESlLy1RRk4CQOEcMyyUFVXqyboS/RtQusTQceWFXqQqbGRpy++W1/DqjKCC
	1LSYjTxleBLeISJ6Sko8sTagOUlcXGn85HpbGr05b+tKmFLa+P3ElKSHsxhtCUbIIR/ad64GaHf
	CP9N53E7svVj9ZgEMqBH2dJMVNpnHYHYjq7F67Gc3+6jMlMI4LOJECPBG8wclQxJKTL3yexTlBw
	wR6ZWsiFpQj+5dZvuoUjxR2tOGHc3Foz28i5RQlmpzBwodLSFPhn6g4OPQRguFSA6gNParEd7GE
	+NwHhVc4HQaIc7XDilS9D8MTdOpG6P8v6koN5lGglhZrDV0L0xoXtVbZRUGS+5G6uWM1K0/hRkP
	oVUoYx3s=
X-Google-Smtp-Source: AGHT+IGsa5e5lNXo8l+sgrOnyahKAGKg6Eqeo60aw3JI53jBef3NZl8WnVRZmXUkUHO9BTsU0giJxA==
X-Received: by 2002:a17:902:f64d:b0:21f:2828:dc82 with SMTP id d9443c01a7336-223d9dfd65cmr627755ad.2.1741037468396;
        Mon, 03 Mar 2025 13:31:08 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb602sm82065475ad.102.2025.03.03.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:31:07 -0800 (PST)
Date: Mon, 3 Mar 2025 21:31:01 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
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
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 10/10] bpf, docs: Update instruction-set.rst
 for load-acquire and store-release instructions
Message-ID: <Z8YflWUNESGh4pOt@google.com>
References: <cover.1740978603.git.yepeilin@google.com>
 <c835515c35ec4ed59232adc3c02e1e90aa8ed8be.1740978603.git.yepeilin@google.com>
 <CAADnVQKGF-yD6UZ8Xha-wHu+7Jzn7Xa4Xu9Rju0hL2vFknqNEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKGF-yD6UZ8Xha-wHu+7Jzn7Xa4Xu9Rju0hL2vFknqNEw@mail.gmail.com>

On Mon, Mar 03, 2025 at 11:14:47AM -0800, Alexei Starovoitov wrote:
> > Update documentation for the new load-acquire and store-release
> > instructions.  Rename existing atomic operations as "atomic
> > read-modify-write (RMW) operations".
> 
> rmw renaming looks like a churn. I don't think it adds clarity.
> 
> > Following RFC 9669, section 7.3. "Adding Instructions", create new
> > conformance groups "atomic32v2" and "atomic64v2", where:
> >
> >   * atomic32v2: includes all instructions in "atomic32", plus the new
> >                 8-bit, 16-bit and 32-bit atomic load-acquire and
> >                 store-release instructions
> >
> >   * atomic64v2: includes all instructions in "atomic64" and
> >                 "atomic32v2", plus the new 64-bit atomic load-acquire
> >                 and store-release instructions
> 
> I think it's better for new groups to include only newly added insns.
> Also we probably should add barriers to kernel/llvm and only
> then update the doc with all insns together.
> Otherwise we very quickly get to atomicv3 and v4 groups.
> Naming wise I would call these two insns plus all barriers as
> barrier32 and barrier64 groups.
> cmpwait insn should probably be there as well.

Got it, I'll drop this patch from the series for now.

Thanks,
Peilin Ye


