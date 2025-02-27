Return-Path: <linux-kernel+bounces-535796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C735A4774B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76327189402D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44013225793;
	Thu, 27 Feb 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMRM7xEG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF0224895
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643498; cv=none; b=WYovU9rqpmthE3ao+tSuRs2uoJ4039YF8T6+GvikyKkng92NPs3RDpHh/J1lLo13Wdm81Q+S8YHgIKlEB3BPp59iaFieGyhIJxCFyutw5jAPAfAAVExHo6xpZIFwwHzY9DdgdfGuj2CkKcT7aX1PC9JzX8XefL/6SoguHE5gGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643498; c=relaxed/simple;
	bh=rlwCIU6wq0zg7H7hLkk46jst9cMoB+LfjLnMLeFXeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfx3YGgzbygM22WSxVp2GRonlYiM3tQVygWoEcMBHsi5OxcQ/25n78kwt/4/vnQUlGvddAFuWTlJsKlCaL1iqL+ldNCAaX3TGciLK4RBqLsWLfn9REkpFasfN+9Mv5ReLbqqUXmHLLJb1k+DDB1brAAmIjnxT35WA0k0neio/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMRM7xEG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221ac1f849fso84515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740643496; x=1741248296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVfI19/EVZuMF44ISw3H+kHayQljK7ILxbA5Nh59FJs=;
        b=EMRM7xEG+yTbhmYBsJWNgcQhIcBhOeElh/VoeymdLZtlxbjx38GbygixcY4IKZyAgf
         MNs237i32n8nHjYBpjSSMOXyjudeO+4xtfrTrQbHRQLTPabbENaC85196l+ajX1wRfAv
         k6Axcs/QB/sKhbXYOjtzq8aRLZoUn5B/2VrEROLbg1Vzo9MCrVUnXnLpsWnlhLxgIOcC
         12gQnBm/Ad4ZRrtgaOKnle2Ol/nVxFvSzQZ7OfXkgSIaPEIyDyhd1MLi3twBf0jRB35x
         uEHfW6dMfQ1r1uI4I6FYbUW0jocvYEJq4Pbqwth3YSxxp/0X9YbizziZzjWtumcpD8kE
         LnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643496; x=1741248296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVfI19/EVZuMF44ISw3H+kHayQljK7ILxbA5Nh59FJs=;
        b=kDfwjD8HW62xtyffbAEYIVzQe7CuSWBgXVom8h2/sRxYUbD9QIa2LYTk/1C4MLySOd
         1vix+Lb7WnGhj0NY7GHYbmeYWvq+BoAQYUxOmKDpK0B8M2urLBgP1aExduo+sSq1LWq0
         Hsb1P0T20MQqkupKytbjs1CPn5CFiyJ6zHxyfOyKZcCgX4GZfjGEgJ/UvfrIQyXrSZe1
         k/sDdKccOOtb3LUVzlyieI/0x0zh8LymrNzYZaFhB8q/v8kQpWufnQ4nGQ/v3aXuBiRh
         iBv91vqWhRlPYztk2fdUpYD0+tul9nmGofXGJqVkCibcljs0/gTtmJ9F9uNBwWnQepmR
         kF1g==
X-Forwarded-Encrypted: i=1; AJvYcCVba1+7jxHdscguszM55Nxb9PtL0muT2o0sA/1Io5oIYv+2V8294DkQjnelyAmcO446NRQJEtWPGhgC5yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnNiTrqu5EQR1XFYf1UHzvnEJyRe/zCLFrGUkSUBqvEJsRVNA
	UIdZYK/es+4G+vMISRFQpXZx5KJcXEXnjA/kEBkctYBcMe4vzoQAiRONb8H30g==
X-Gm-Gg: ASbGncuFxnCnKQ84iN6mAJiSnqr2DhghvV9mQJI2TrXNVs5cuELva5/M5i4J7xySfQa
	XP1E7fnyQH0CkN85RaLBKx/prkR58nh0XlbqQwLAledeil63YTMZnt7yc/huVYaaH0l1kc2wYNr
	tKm3Ymji2LkMg1ieAiUN/moh4LlEKpQGlP6Ts/BeXjLjmcKHqswiWIlXTBmjYZ6wwBHZHoo5Tml
	GFiQeOHVjWVmE/D+99tIowoVi5UQJJffD+6uW76/b99a6yP7OtKiz9kiPazUeYvUs5sp1w4n4dC
	12u8Ae9h4sQcN7CBCXAz1O+FzfnP/qO+TnC5kIJSdNPdDmAi3tM4cLqX+TLB8Hov
X-Google-Smtp-Source: AGHT+IH0kXAKW/WxeUSAkDJ6hpUz3G9Z8tiiq25Pho3rUzHzfEO4KswpeTVilRNrTdkuX5sOdpqUXQ==
X-Received: by 2002:a17:903:17ce:b0:215:9327:5aed with SMTP id d9443c01a7336-2234d84ead1mr1995945ad.20.1740643496268;
        Thu, 27 Feb 2025 00:04:56 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4cd94sm910482b3a.38.2025.02.27.00.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:04:55 -0800 (PST)
Date: Thu, 27 Feb 2025 08:04:50 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z8AcosbkJ_n8wEbZ@google.com>
References: <cover.1740009184.git.yepeilin@google.com>
 <e2d7bfc155a26305a3024aaa102a3acfa693e565.1740009184.git.yepeilin@google.com>
 <CAADnVQKEcof-WBBj_W=GpsP0Tjm8hyxeWc06243ZBR7_Ua0Gfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKEcof-WBBj_W=GpsP0Tjm8hyxeWc06243ZBR7_Ua0Gfg@mail.gmail.com>

On Wed, Feb 26, 2025 at 06:18:47PM -0800, Alexei Starovoitov wrote:
> It's border line ok-ish to delay arena ld_acq/st_rel on x86 for a follow up,
> but non-arena on x86 should be done in this patch.
> It's trivial to add support on x86-64 and
> limiting the selftest to:
> .. defined(__TARGET_ARCH_arm64)
> is just not right.
> 
> Even arena ld_acq/st_rel can be done in this patch too.
> It is such a minor addition compared to the rest, so I don't see
> a reason not to do it right away.

Sure!  I'll add x86-64 support (including arena) in v4.

Thanks,
Peilin Ye


