Return-Path: <linux-kernel+bounces-548950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3FCA54B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A51897114
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB720B1E4;
	Thu,  6 Mar 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM2iUKxt"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D720ADD5;
	Thu,  6 Mar 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265808; cv=none; b=lAIqGskCj8zk5A+2J+TSChT1fIF7Coswo8VMDeBTajDC5qsOKcPWzHESSsxVQRJ7Ozni0Hg6bOOVopPzp7Gal6ALNANyBrIYy7X7xu+TpFWcKmtVu8fsQdJLzSTemSozO8ppdE01JMWUez28J0mjrpea4CmL/Qj7PiUbMu1NtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265808; c=relaxed/simple;
	bh=O+cqSRTMgwQe0+PhMMLNR/2z0UeUe16GaZ86fSWb9M0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Uy/oE72iO+4shxdcb3r6rUNTETMvTi2chaws4lTYvXBnYmYDyF4/X8Ry30Kjij9QeQvmLKmCX1Ucjzfbm1Hx9dib0ZzOxPFV7E96is1ugVlaYJtJB+//fs/RSv6apLt7LOKFaWKlmmBTcwAGDL8mJkuU9FEy92kIgiOpX72eY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM2iUKxt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so7927225ad.3;
        Thu, 06 Mar 2025 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741265806; x=1741870606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04e5QVlW7LFU5EHlao9T7yWPAHQynGYSDz8qPerZSOo=;
        b=jM2iUKxtQ/PqHYerhupIirD9mXIvyXgxe3bGWXGNtQtoVAIM7IM+mMtI94NVDZmYzH
         VhVpoqix6o0saKWMl4hGgz9gN+oHKS1sDw9C4C1JYsnxU6bhjE+B2zqIBLyqgJ0ddhLR
         npX8tik4x0/YKicBgOrcxPKh7SG6cP+JAitTVHG29kdvYKiUDWfrJntShW6Yw2wVsJia
         eZTWn+11egvchU67H51SRjH98BMqoBdZ/Onzaoj5h5Ws7/J8Iw14mkFdTFXdGSQYRJtB
         NjLXxdmNpbhhdaeRzESvwtpwgLRbG3h8xB5gxa4YdYb26rJ8ZpO3OT3kMg4m1wCObR74
         6uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265806; x=1741870606;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=04e5QVlW7LFU5EHlao9T7yWPAHQynGYSDz8qPerZSOo=;
        b=M8/LGujhDx7Gvb6cSv1d+69eOHD+ALHDSBc7pFt5N+pBVOk/X+2c6jWKurtgRk4OLi
         oNcMgGDP4JzO9zX/3IXZf9JKrhnGNdy5+JCJv/p842cRl6Od2k+zE/Jxp8fzFepC/aQK
         TWAA7wIMFRHUnBQfbfxm+DAVSDSYkqYBC34R37pTt9eNN8HAPWJLT5UpNuA5/RhR/8yQ
         XwF2QO2Sw2LxxA4DTlM3SanZVf6Et00jbxMwhVA8No5L2gttqvVN6AcQZaRE8gBkwNAl
         DMDsrv45ek50xhwFeI0LqCnCubq6uZ9HW9HqCdH9xhJi9JOrAmPeO7xuud7mg4as1nhI
         AYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+nrjCX8PCTKn5ukjle7O02zXxIr5uf9ZKHrF0jhcYO0xccn6kGFrFs6t0HsK5lp8OYpEzoFnH/n7PHjz4@vger.kernel.org, AJvYcCVaF4PLXwfAbjgtdF6t6T/39nSAVSCPM76robxn6P/xSNPzFPnEHMZuELy5/b9OlcPPPYlqQ7Q5So4=@vger.kernel.org, AJvYcCXEtgq2YDLKq7rNwnc8ULoTiuc4rxP0WmWtkUsJvQ34c623pOj+XoQUsKy0e6t7Xi8j1IWCyef2o8Gc6Mbkn1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HfoZZ+MiLeH270SyDRoNpDU9mEWkctpDuFQiWNckp0VnM1pg
	pP28Vj2yOF6qXQ3WVN471tc3aQ49Kf4vaCHLxdMUL+CN2OcZADzm
X-Gm-Gg: ASbGncuaEld//0xdLFFSIuIZeMZyhVW98QqlEFwJjQ0ASW7NU/1GoNnQ/E/zDUQprFr
	GdUJ1Zry7E6+5awH21vTvt170DDnVIWwtSXUHwkVN7Cm4duqvcAyudLoxytdeNi61/fKlCHLnIA
	vq+uXnA0SSqzcfn8Mgf2F0P4OkUs3iRsveLb62h+dxEYbJiitzhyQRp6m2+hesr0x0rXHhQuKrf
	N6vBpknAQcar9nnROjAIjN84LS9FXAtgc8SiOQpIf2Ay31KtFWb+vneyro8ozgFyu3k2WUvcES0
	YMCIfBNlvDdtd9MNLFawIYeCj8J8qJ3NkZcvYFVOjDzoSqNNrKuhOgD2lEPThwMUP0wvOafHbXr
	YBPqrJkPrg06pWmuPIYa+8cz6hls=
X-Google-Smtp-Source: AGHT+IE9D2V0PlMV5ZABesh7TdWr7X7Bayt5c+xg1q0luPahNx96F8HAIiwpPIbDk09xv10uSnCpqQ==
X-Received: by 2002:a17:902:ec8f:b0:224:1dd5:4878 with SMTP id d9443c01a7336-2241dd54accmr6811955ad.7.1741265805743;
        Thu, 06 Mar 2025 04:56:45 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91985sm11384815ad.194.2025.03.06.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:56:45 -0800 (PST)
Date: Thu, 06 Mar 2025 21:56:38 +0900 (JST)
Message-Id: <20250306.215638.838863448505767234.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
 pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add initial documentation
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250304173555.2496-6-dakr@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
	<20250304173555.2496-6-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 18:34:52 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> +Delay / Sleep abstractions
> +--------------------------
> +
> +Rust abstractions for the kernel's delay() and sleep() functions.
> +
> +There is some ongoing work from FUJITA Tomonori [1], which has not seen any updates
> +since Oct. 24.
> +
> +| Complexity: Beginner
> +| Link: https://lore.kernel.org/netdev/20241001112512.4861-2-fujita.tomonori@gmail.com/ [1]

I posted v11 last month.

https://lore.kernel.org/netdev/20250220070611.214262-1-fujita.tomonori@gmail.com/


