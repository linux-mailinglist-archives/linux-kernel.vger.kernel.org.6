Return-Path: <linux-kernel+bounces-293217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70852957C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EBA1F23A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7341C62;
	Tue, 20 Aug 2024 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KwGp2Asz"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697B2F2A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126227; cv=none; b=fYAZlabR8z8vFxBkF74LYSAPuCLQOrKe2TDbE8ot8YFZAUpKFtBGdKFF0Oc1JMgVFP21G948pA+K75zB3zjocDOnE/ixLlnfhbbhTHAHNn47jg4j0YE4ffRdBhvQ635S6ZK12eNgQjxKPrmWItq0qlT14qNBBU/yd4FeV/AZiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126227; c=relaxed/simple;
	bh=Shxk1Ily8RHQXegy38g7PftiG2ZHOJS4jpgB+tabUQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0axbLqiht/Ok/v6r5J8Gt36qIRpNhPx2dBltEpXMV29XeD3GU54ICQaDgr0Xi9akRpK6+pdCXYhBCaVLddyAb81XGUtPGfOmxOCeT/D09Ye3yWFxD9C18UsyAvOMHVU9CXUm6a1lcVYgKFMTqJFf+HQJhTHejXHF1V8VlA/bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KwGp2Asz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-68d30057ae9so46989557b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724126225; x=1724731025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BlLp8ySwbtC/N1/BK5qckNa0L23by1DV5/7Cbxmm6A=;
        b=KwGp2AszFDcoiyAUJw3IJdDGkNOOyAyoNVM/x44fZqU+xuwR/fLqfvnm/J1EBKrQr/
         8uQ/fkuaIcEoaVikRsMTdHmrPFNvZZTIDJ+TMd/v6Yh0Qr5akBhejk3c40bpLMWDxSP2
         SV37ABQBUWmI9NFRn9EIxy9p1sV2T7hUBjUt3ro6CJaVU+KPGaQyNnsfFfd6rYSd/oi3
         eJNY/tdRiPOdfrGQmFl3jy5xk+kjp5GmxgnxlDurYChNF7uTgJ/URL9T6jxLKyouQEv+
         v30W3pmktDpb85XOhVvwlHfAE0x2Znq/CAvk6YGokkEvCDXLI+gjuZOHtJSh9stYyxcy
         b7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126225; x=1724731025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BlLp8ySwbtC/N1/BK5qckNa0L23by1DV5/7Cbxmm6A=;
        b=KGMQYmXJjfa61IxJysB+f113jdOJlgdzaKZD7nnW51a0dCELs/xlWARcwmbb4nGZKj
         ri899qRy9xXgHQUCU7rEdoLYk2vdd/3jH3ahklySLEPIU3IbpLIf+4LuqJhNAwWUsmYA
         gvemZIDSGmtYp8YmXYe7OLrJ9gS/FeMo0D0q4Dz9ZnoXWSH9xwYwmra/7yeWjYRtj+rO
         75AVMMUAOEEP5qlztcHzkAB19A4+1GUwZrg7E3RLMTmKNk8d2MYM7nXIEYTpRegK+zXG
         ECOqkhDWukotxV6QFnLbMo3sNTT4hAWoL6wCIX5RHJuKHnkHIMvkdlmiiUZwQ8UKjsxL
         bgMg==
X-Forwarded-Encrypted: i=1; AJvYcCXoJbN1Na6iKJzxCna4qMlN93aNKcuFRj/o3Bjo5IE9U1DBuvXxaFQldAbmch182DVD51mv2+HwHOn864U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+DflXt6LfPvZgldrAi9swBt02EJxgRDEBu4gtY9hFt2S3fLM
	s2bR3WXboVK71NIxbXow0slNQyu3rqvpC7XNWRIOFnYKadRCVgRHh3HhY2423GVNYXwdwYZ2Npr
	8nlrbmXOFDQJlh5mdt0O49Tzk+tu7VBlEFf381Q==
X-Google-Smtp-Source: AGHT+IEExajBlY/glKVOjfMsdYuk7N3HbpX3+R5vKAaBwb3zlj3A/SivuRq1ZnpX/obDae5kv/3Zih28gc1+g+bhAz0=
X-Received: by 2002:a05:6902:2808:b0:e13:cd13:25b7 with SMTP id
 3f1490d57ef6-e13cd132a8emr11947868276.46.1724126224896; Mon, 19 Aug 2024
 20:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111508.1373322-1-ruanjinjie@huawei.com> <2ee770cc-b5dc-1837-aa65-6b2519e03d70@huawei.com>
In-Reply-To: <2ee770cc-b5dc-1837-aa65-6b2519e03d70@huawei.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Tue, 20 Aug 2024 11:56:53 +0800
Message-ID: <CABgGipXpYzivDF5zyLL+2JSEE6q=SH6X2DKAERbf2WWaVAenCA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove unused _TIF_WORK_MASK
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	samitolvanen@google.com, debug@rivosinc.com, guoren@kernel.org, 
	songshuaishuai@tinylab.org, bjorn@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:42=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
>
>
> On 2024/7/11 19:15, Jinjie Ruan wrote:
> > Since commit f0bddf50586d ("riscv: entry: Convert to generic entry"),
> > _TIF_WORK_MASK is no longer used, so remove it.
> >
> > Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> > ---
> >  arch/riscv/include/asm/thread_info.h | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/=
asm/thread_info.h
> > index 5d473343634b..0eead6b7b790 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -111,8 +111,4 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct task_struct *src);
> >  #define _TIF_UPROBE          (1 << TIF_UPROBE)
> >  #define _TIF_RISCV_V_DEFER_RESTORE   (1 << TIF_RISCV_V_DEFER_RESTORE)
> >
> > -#define _TIF_WORK_MASK \
> > -     (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> > -      _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
> > -
>
> Ping.
>
> >  #endif /* _ASM_RISCV_THREAD_INFO_H */

