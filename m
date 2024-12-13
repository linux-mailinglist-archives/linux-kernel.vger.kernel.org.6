Return-Path: <linux-kernel+bounces-444974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DB9F0F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F8B188220A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15041E1C07;
	Fri, 13 Dec 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVZUeoSY"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2B1E102E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100985; cv=none; b=kb7KS16hhsNL6GziyXr+pOqVaEv56x5/nI0OKvvzxq1Z3tbNWLcrRmI0e9v/LmqydJATswWmVyXZGxXb8G57BxoWgPD5Sv2Sbwe3ixCORQ/tGqRic75TI0YWC53I6Fw8+xPfIcOAGTiLEK9upPpJKi+C+91Fj7s/g4EpgSi0Iw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100985; c=relaxed/simple;
	bh=n10QJJ55X7HBx/y6wW0M+3cbs5jkItom5BI54bxOzQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWsJz2vthMkdRrzP1M3waBioukvCLMgug4XeyZ/6KR5lEqFaOGFgbE65AWUPMeknwBrNAFq3D/8vwKmzyBG2dUEeDl0NENu5LdtEzqLqH9/6KFVvZ/AtAep5nOl0mo6c7s+L+Yo/PYMvtei7AZrX8gS3i5D5JhRAx6S2ZFseZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVZUeoSY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1219912f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100982; x=1734705782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQN3UYuZLGOWyMzw87AuwKy2RXu1GJbFM04a9jmkj8Y=;
        b=mVZUeoSYP76hUs2+gZx4HnKFCscR7lkFe1Txxw8+G43/gVtMIpHsr0lvNZ56MrI187
         qHTy5Tt3sYL7064O3hLp7gA+O30Q+c/FM8YFALNB2YC1IeL7fwtuGmrWlv8qtBom7DMv
         sjgKBwH903U/5PMFP0kPfLf7dxQDe5B5yIiF9auq4JNC0It93wky51gr3eLOcXwl7B0+
         HPJIc9fOTCwUH4J2BO5R030b6J1kELP2/GRbrcTaaf3fF6fiEL128UVyEAjWzO0HesPK
         bOOGnRaB1sRjrku3ek7g0dy3YJ0EgNuXWvfFjn4qAOYdoUrHq3BK+5bqW9otBeG2JDQT
         8m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100982; x=1734705782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQN3UYuZLGOWyMzw87AuwKy2RXu1GJbFM04a9jmkj8Y=;
        b=VULdWO73+BVFBKm0JLSQkkj6+uL0fXQjWKpAJ0BDjFV5/HzM4gI0kAB0fU2jAI0zTc
         GhcecTKs15p0KmQP6nsKcA/CdD7GKCeH6zXuycLxR3F4EKLlcMW7WcWuFzB9SFflXs3E
         hj/lvxUnJsiHGUPmNbpWkUpyu/kuU0GQeSuZ5VUd+mKUxlcNbamXn1v6VdPJg62XQyVj
         Plm3fjllj59/7fLTrsoRjDWef6F0GLtmrxkUGqELkUK3B0aBCsnBb5EzUJFluEepYLKc
         BjnYvvLAapSF+IOjxSahAyU0WOHQgqSSN4WpjAZSWDvIzoDuMqWd/0TLgyCDXiV2fy4Z
         0x0A==
X-Gm-Message-State: AOJu0YxDmPAhJqcVhaVPTlQOFM/9tJ2fapc9KgMxP33nu3RSWVTjRXUy
	KpD/nc+B4Ia97/eQaBpeoN24bhQOGtuP2hUfaeyhRxUywchGbuvIjgKPWX9QkKHV0c9VPrB9lJK
	If5FSbt7jU4sKbfOLK0GH1cbWRclYQ/KQtozhiAKB8LC6I4FyPVNR
X-Gm-Gg: ASbGncunTxWfv3FOlN2Y5BE8lojEBWNUgqpGLceDqkJAHuWhbVXA3yNraOhTfmPLX/h
	MuLoE1YWiQVDvkJgUD7ZrdGtaGUH+2e9gCJvoc9M=
X-Google-Smtp-Source: AGHT+IFRaxqBEHp1EzTccBLpmSFilJ8Fmy1lyZGHWnJs443ChBVzQ4iICffogcA7BsiGE9GzVjeQDb9JHcgUu5Zbkz4=
X-Received: by 2002:a05:6000:188e:b0:382:4b69:9ca4 with SMTP id
 ffacd0b85a97d-388c3a8f0cbmr1897964f8f.26.1734100982038; Fri, 13 Dec 2024
 06:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com> <CAH5fLgiB_j=WbTqFs6o9-WaUOHC_-0+nPXT_PYD_1bZ75+2wBg@mail.gmail.com>
 <dvpyp2d4rrxdzdcyu3mh3wdsegi5qcmnp2hitfu4guft2igacg@xfvixz3tsiss>
In-Reply-To: <dvpyp2d4rrxdzdcyu3mh3wdsegi5qcmnp2hitfu4guft2igacg@xfvixz3tsiss>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 15:42:48 +0100
Message-ID: <CAH5fLggpBTZ7E4M5W7fN928z82_+zpD3kpvxinG9nfsu07Wkuw@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:47=E2=80=AFPM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Dec 11, 2024 at 11:47:41AM +0100, Alice Ryhl wrote:
> > When I sent this series, b4 put the changelog stub for v12 above the
> > cover letter for some reason. Also, I'm not sure why the list of
> > recipients were included in the cover letter. Any ideas what I'm doing
> > wrong?
>
> Yes, and it's a common gotcha that I don't know how to properly address. =
For
> the moment, we use "---" lines to indicate the main sections of the cover
> letter. There are three main sections:
>
>     The main message
>
>     ---
>
>     Additional information
>
>     ---
>
>     The basement
>
> Looks like you removed the "---" between the changelog and the main messa=
ge,
> which causes b4 to stop properly parsing the cover letter.
>
> I'm open to suggestions on how to make this less fragile, short of "use A=
I to
> figure out what part of the cover letter does what."

Could you print an error if the --- is missing, that is, if the number
of sections is incorrect?

Alice

