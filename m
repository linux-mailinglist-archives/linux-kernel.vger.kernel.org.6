Return-Path: <linux-kernel+bounces-400711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE79C1148
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF361C20F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76431155398;
	Thu,  7 Nov 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhadDNr3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86C218925
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016248; cv=none; b=LEBnQxhyPfHgdf82ADMsCS0K+yxZMw+OSoZYt7KPONHtLXy+tb6Opb4ka+abstCIj8p0wbeELFqVfethNNl6+wR06u+MWoSfLWV4XUWAmq602FxqPvx1SOGqLGAn9jihLYiX4VseYZWf/YIvBLVI44NXSrovNCqWMitxBgBeZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016248; c=relaxed/simple;
	bh=AB3VetWowFNRSSAyq19Xh0K4n5acDdQvX5pj6womwf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKKsdlIWI1IAaMXZoxEfzI+yManQr5dFGpJu7rh5SYfVOvonxtMqrRYrfFmUwjFkVmez+uGm0D1Q0AuOBp9GOrhABSuyhjgjU0P/clbGmdgBYz/9p6ZAuRiO2ALqZpfXeGRMgIUuo8TxCr3vIx6cSgjNXHtGPaXPhYU12e1GGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhadDNr3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e617ef81so1342e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731016245; x=1731621045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB3VetWowFNRSSAyq19Xh0K4n5acDdQvX5pj6womwf8=;
        b=LhadDNr33r4a1ZKXZOkC5OmfqvqXUnoAciiV0o5/Yj2PztfqFF5XmqzAtN0CT4hSWt
         f09YtizJEnD1i/HLe/J36Nj2+IyiZJvJRfrM3KUOBZ5bIX1D05jyWauwJrvLen2SbDaW
         ahgj15hZG1vasw6MsV2EKzbfZzls39hdDdpvIzh9c3lyVq1YYe2Ua7R2E6B4Di7CMXLR
         ZoX2fGhYWf445KErwNcOLQtTKzoqHTu1QfntuYz5AOKRc20/L5feto5SbTdBHHszKWQy
         tq7CXbPBGVYjlrrdy3ENoholUT3URmLarvASJJO3lYPlrwFN7oBkglGgOo4bycVie3uP
         bDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016245; x=1731621045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB3VetWowFNRSSAyq19Xh0K4n5acDdQvX5pj6womwf8=;
        b=rDISejqEtUXMc1Z/61P/nSVvTTmFWfi3i08pZnYgTzppTBySFRukc/jblwg+RikIGB
         ACniVEgABKXBdaFcPEqKUU36DtpoBf3DPRfwq3YoSIdNz4ieXOSYVKkuDD26uzhm8lRX
         oKDbIlA9RR84oENCpHdT7RMuJdyxr4jXQWfh5R8u5y7FWbdm9i78l9fWyJW30gQ//+Br
         m2YNJDj+j2moSMeY1qKE0m0aznajGBODaf7ukxyri/UD4Us8muXtxJ/7D4zaKgBGlhwk
         Z5W1R7u9Getl7vR7on8cZOkKXhPcUajn0e3cOipxuM1zM3VrM9taEQhyjxR6CXKSuozw
         Jnvg==
X-Forwarded-Encrypted: i=1; AJvYcCWxoz7I9VWux3sYYmUAsF6wL2ZB7OJ6XBPJTj2dyJ5AMxQ+aVKvGlSCPeVPeySf2VghMnEg/GTgFgXciMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy3yMiwb6gbWdz3PoHSDT8quliFRJjajSIFCStJhPPOeQ5scL
	Hu9tOKC4zgQGx280YwAuoRvQ7p/YFOnyQJhIl4oupq9OcT8Kv6o3GnBmPjfwumcTOxoKpLknpVK
	FEiqElrz3/t3+2aRL2nCOhmv+LGkRUY39l2eoihHfp0W+UM7/4w9r
X-Gm-Gg: ASbGnctP8fyui+S5CfuAUei6QYFQiIor35NvP5dk8qhtGp0ybZO45UU6AOttQhJ8b3j
	jbJxm+Mh96fjTtOKp8PsWGUrHX4ZeCDjPM9f9Kitsp1wNMJI+6M7UYWSuJvg=
X-Google-Smtp-Source: AGHT+IGpfJyng1ypm6WmdqDsCpVtRQMeVt+IanXMJj9qVi9mK3YhK0vSfywum2VMxnQjfI9QtpUNvTgo1l7+Rua648Y=
X-Received: by 2002:a05:6512:1143:b0:530:baaa:ee10 with SMTP id
 2adb3069b0e04-53d8122ba4bmr445801e87.3.1731016244822; Thu, 07 Nov 2024
 13:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Nov 2024 22:50:08 +0100
Message-ID: <CAG48ez2t3-dhJibxBpM-C6_0=vqKC4kU8Edu-G082ONpd6jT_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
> This commit introduces do_zap_pte_range() to actually zap the PTEs, which
> will help improve code readability and facilitate secondary checking of
> the processed PTEs in the future.
>
> No functional change.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Jann Horn <jannh@google.com>

