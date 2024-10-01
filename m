Return-Path: <linux-kernel+bounces-345266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091D98B3E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332FB1C228A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971A1BBBC1;
	Tue,  1 Oct 2024 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExA+R8vS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A06088F;
	Tue,  1 Oct 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761632; cv=none; b=kdC3GUHHyWn+LBBwUhvwbukZ1qmD7Rp9N2KuL3PZraLBsNOBDGBuo2HpR+Jq1Uh7X7VZ37EoGK2bYlqgUGDfrIqn9MlsrcM2YMw4EGrY5MKOe6PMj1MYkPAjh4IU9qPiux6VK4Z/iYxUx7t11AaCJtWBMvfJesU+NCXJEX9gKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761632; c=relaxed/simple;
	bh=2YoZKnvnQ588Ub4cfcKD9Xrsj8C9PwE+WXBjFCfb8Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdID4Wt2SXCtFy3xKpwuCVGgGNH9J9wuhpIU/nKA8uw2P8e5EzVi2yNQVr8jhmq2mKhcMkv2rm6g69N4nWWFN4973C0nUAnJVt3Je3mUTOEV7mupUYXDV7VHkgiBUyDdjD5jF/VmyQxewUSLcmY7FwfvBWuJKujt5qVVgrFhyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExA+R8vS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e084dc44bcso858486a91.0;
        Mon, 30 Sep 2024 22:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727761630; x=1728366430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeIZnK2JQRXMlN+7jx211J8595pxvr+CsQntYwwTAI=;
        b=ExA+R8vSPFnwA0Of3SvOwmSfRjHVgsuZuaP1bqGP/34wpstsLVFzgHd9DZSwGQlp3F
         G/ksDjQ0ATc7FjXCx/6eFGIYaNBXqGxr5cZCcbWQo4Z7/qsdoJ5yRhdSGNDBCAgItn+j
         SlfKdiGZQ1cPVl+y0wH2OiXqlJCPHxKaMIUjhaKjabrE7OnmhvogXdCQvljp0q3/QM7g
         8x3M46ZjlUWe/4uanYO71QzVrpYf0QbnIhX0rc/anx5ql71vjj5WLCfNckXUSEtW9AG2
         IJDJA8rk//rZdPIb2xVT0Xt5+mNKHFuRICX1PvPdaW6baf5E6byIZ3km8mcoONNppqxp
         h1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727761630; x=1728366430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeIZnK2JQRXMlN+7jx211J8595pxvr+CsQntYwwTAI=;
        b=vznNFyy6ByEiWeVQo9MUpHV4l+ijijTXNszHt371Zw2L2lQo4hlTnL+qIhG6CY9EsI
         Zp5qpdP67RjoOT+zIQ8X0fZ1jby8mfxQDSGVmOjE/vSc+hRzthP4JYfu9Z9IpAaZy2FL
         kASIfL8GLPOopp6H9yvEEVqO/TC/2dMtdTaHNCUaHFGoUDHdo1PI/YY1HnNZb1PawgDn
         VhYA+4dwYARIDEFSbydpLphmM8AZTuql2/nY2j35BH1+TuHbdkMaaIk5Amtb6pmGk8if
         7xs8/9CoKbgp97lJmvXa34hgJiiUvbNLPVYRm9K6/WJQ4YY4Xod9l2a32QOKHwyCQW3j
         zQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKlLGKNIp5EY+Y243VcHzEprO9p4GHJsjQWQwkeacTngGyQPaYMaDs0jT7jdLlXG+w46SMTuqV1SP65Q==@vger.kernel.org, AJvYcCXTqrzMDHvuQPKPgruKINAMlzWvGE9ghh2/b/QqQiXz/oS05MWGFPRabTzvNDoMgpcEI9kRHf/bfucrV4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3R2UZPp8tIcBO+UYSbcnENngWPob+U3QfY+GDXgGPxML7dbJf
	ZEo+9m8K21PoecDM9Yd7SEDHhuT+Wk9ZHSg6767zX4jcLnbXiUxeV1ORHLSS5gD9Ds8T0K0v0mt
	1fMafiZqXJS9EuHd6XGHQd7sypro=
X-Google-Smtp-Source: AGHT+IEHcSYvIZs92iua2ICHC/3thnRry71zX+LuM9P1WqNmiBEJdo02XLGq0CVxCpRzoZTApToR3ljtxekfqocmieA=
X-Received: by 2002:a05:6a20:3946:b0:1cf:37d4:c4f6 with SMTP id
 adf61e73a8af0-1d509b25e12mr7490247637.4.1727761630050; Mon, 30 Sep 2024
 22:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001102839.77211fb8@canb.auug.org.au>
In-Reply-To: <20241001102839.77211fb8@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 07:46:58 +0200
Message-ID: <CANiq72kqGRJdXmSaeHeJL3XiPJyAOV-4CTVwvhTrXQXuYaXzJg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 rust-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:28=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Today's linux-next merge of the fs-next tree got a conflict in:
>
>   rust/kernel/lib.rs

Looks good to me -- thanks!

Cheers,
Miguel

