Return-Path: <linux-kernel+bounces-396869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9413F9BD365
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526CA1F2355B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82B1DAC97;
	Tue,  5 Nov 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VMt9XOOx"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A617BB25
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827768; cv=none; b=aDHbwVPDMrshDu05ZEQ7GbHFutfb8hSUwc0oAnbPhF135cNXY6+PS2J/b37asrcfJzCPfwU47udh9GGLfB3ixlREC8gRUML+g6Rg/cmyLfoI+Mfjyt/ZvDWvxigurmwCWrSNeEbUGUIvJkxEHgEMYlmkhJ5FQwUk6N2xt1HiDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827768; c=relaxed/simple;
	bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2TIAPkkyxwjlHssu8HcW/wbgRMnYZQEaQMvqwcFm7XANobhVkHcpc9pjghy7G2jQy3vLhQ6azEkZV6GN4TUv9Z60tqgoxXj89PjkajalObqsvs1VZB7CWrU21LzhYYuCaNGj2EwFX6qnW9ru9uFMeM+otuE76a51GbHOKsOAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VMt9XOOx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3b7b3e9acso49757737b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730827766; x=1731432566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=VMt9XOOxUljvPEn+YrTy7uje8xYkl4Diblc/eRGVHUUPANWCiYbx8FJFDk2v5fB+Ij
         9ma6bOMUbuXoY3VNrHkO/8zfTK9njeN1c6oaCDhku0BwV9gWt/3G4nQlV7IYUQljNW20
         vTES9ocuRSmq5GvYDFnCNtna8F24FQK3R/ba4SLYxXDlOqC5+J8+l+MFlCT8wYFBFLLl
         62vubymJ4Mdms0Dz2XyN4UmQRdsdvFIWcXRN2vWYFokH6gTmyoAgJKJffjpdV7cj1ihO
         Poqa2P3id94ufFaNMfSzw0yihW+plA0Wf+NfbiloifpoPA1X/QoD8k6lpWbUPDTuQa+r
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827766; x=1731432566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=md0Gc5Sjwmm1kGcvZ1oub4L4wFs9kAOkltURWnHZM8zFnK2NWLXE6m3O8cIyPJ/VOl
         wFHkzGJfQamZzcpAgcXubBlBjKQ8TRQ6wYeqCtcZzfIlK/p58dsTFJL//w9KeDc+owdL
         kmM1LqgNNZnyL8bHBnXC2tRZ8Eztc0KLRGVEwKs+rKn/Oqudv679XEzLerhEA9iUba+6
         X8pBYOK12pF9IOuXqMvrfpl3KEDKY2flRMWX9AfHAeK142hULwXpOsfPYVGTAxf8uLRO
         D4m3AbobDFWrD+Hvidi4youDPBL/Hz2kTLYHMmYEhbcEs658jJ1HN46T1Q3bq08hQRus
         m5rw==
X-Forwarded-Encrypted: i=1; AJvYcCW1ajZux42gYgg+hHo9wBPk11y+IZKZLTM1aoSAl/0kgci4yAPpROF6c6Fcr1/WrvxeXBAn/iG+unhBMfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszvA9U9IQRjCEqxX255NJi3zIj0ZA2sdHGE8dHG5vbAv9M6hr
	d7+UFx/nn5bwOdRJV0PnrymihmhCifsMYDx/11T1Z8Rv0KfXI8c2dy5jdgxh/6iRUsiaNBDZR2D
	Dqekywv8AlnzUFbiqnO3j2aqYEZwEbcnp599A
X-Google-Smtp-Source: AGHT+IFOtdS0rX3FHLkNcUtzfAk26Yond8xCj8zU0zoLRnwQv6qRHEuvJmQX5wXTy8+vzA4PqpNS1GJcb9sSajMI+aQ=
X-Received: by 2002:a0d:fc04:0:b0:6ea:7c46:8c23 with SMTP id
 00721157ae682-6ea7c4693e3mr84772327b3.35.1730827766330; Tue, 05 Nov 2024
 09:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011150522.2697216-1-stefanb@linux.ibm.com> <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
In-Reply-To: <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 12:29:15 -0500
Message-ID: <CAHC9VhRqqxty8_ht+S0Wp-7hgRT7tzP+FR7-P-kui_OkfnPFMA@mail.gmail.com>
Subject: Re: [PATCH] ima: Suspend PCR extends and log appends when rebooting
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com, roberto.sassu@huawei.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:40=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> Tushar's series is still needed ...

A quick note that Tushar decided to leave Microsoft, but there is a
new developer coming up to speed that will be picking up that work as
a priority item.

--=20
paul-moore.com

