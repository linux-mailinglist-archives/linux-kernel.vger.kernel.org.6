Return-Path: <linux-kernel+bounces-420910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7A9D85DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5A0B26067
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A3199920;
	Mon, 25 Nov 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvVUIp19"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F3198A25
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533755; cv=none; b=J9UvfhU3on4h/cT+7lccnFKS7oxSacPX2DbDeEFhxNWMmWoOS5mUalzWEDfz+g/uXzqYddEy/oY5S1INYDysJotporPjywrtKErZYXY9HVOC+M4fMhdzY6Emlt6HgIpcxPgNlm9YfI3GVGnB7gnp7lZC/TR8k3bCd73/ticLpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533755; c=relaxed/simple;
	bh=uDjIS3T+skIVriAucuNnm/jHl5kw+SPTiNT5UC7q7ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSybulCLMOlRwEqBsKAsX8mQHv+bQigehm+ju1/0r8k+affaR4igjntwFRI2Dc2hXKpJSPlZFDCoPAG+t0LcSMnxmcQqsZBT6ViZmyypt2uiRxzG+msNzaZomPz47ZWPQQc030Q5zuQJNCRgL/b9ihWavBL0S2nozg8aMpShXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvVUIp19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732533752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDjIS3T+skIVriAucuNnm/jHl5kw+SPTiNT5UC7q7ls=;
	b=KvVUIp19NfeilWaMXRWtA/Ifl732NSKNG1dYF+/q8+o34LZ+/DHy6ZzJx0LvPNGvfx0YOK
	yICh394lFziiT+hHXj8SMkgmsHmVaHh26QcmrGe559Iwe3r16T2FnrnkrFdCEBWm8p6MaO
	0/wwSjau/I1V7DdFRqm0Oi8ZCGKjG0Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-jLNb60ujPkqfIlq0yRySDw-1; Mon, 25 Nov 2024 06:22:31 -0500
X-MC-Unique: jLNb60ujPkqfIlq0yRySDw-1
X-Mimecast-MFC-AGG-ID: jLNb60ujPkqfIlq0yRySDw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3823527eb9dso2461123f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533748; x=1733138548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDjIS3T+skIVriAucuNnm/jHl5kw+SPTiNT5UC7q7ls=;
        b=SGomqDUzWcWhCe59ExrJnT5bcKnvH88olUVmgu0igMopIyU84SgzK4uhR2kv7mOXUb
         oJKm/QxqGgG05Pjf35XHlf3WesnN05AyEhFjHDuheVpx6zeNn83p+4vm5z3SVpuLcZfH
         qUfNjA7PMBhIuxrAJsXpL3YquasOX9eP6ku91TFMCUaT9ARxlRspzTagz7ozyhIGi5Sz
         YGmjoRXNLKQwhLVzgKKhnRJTuTFe5KEkgAqfWK+/Odngb8VS5Cx9ek+eb2v6d4eVc1NF
         9UKycrLrCLh5/2R0WmvsFFusr2rJ8XO7Y8rCxEvbuwruAgCcsNPKA9iJQpN99e1DKJYv
         bbbA==
X-Gm-Message-State: AOJu0YzIx0lJEpAJTjTb6EPBCSlXO5Ah1rEQFcebfFD1wbGzFECwJxHZ
	Y94LefETbmHQJC68NZvQcSalWRLle9pSmP9YwtQjXc8Ii3mGLy6wJ16KByxuo5HRWiZUJbp/LQb
	/QTypjpMG9b2qFS7Nv+2nEC40puguvSfgbG96cSMMJLXffjdX7z7b/ro72XgcZwj9KCcz+6+7KK
	k6BEvZTO/Fcwbu303PdiMoNmXHXw7so+W+lSyibHT1/vBl
X-Gm-Gg: ASbGnctzEGJ7YvGmi1Q0nfk/HOtvzMyUhBhvFJDpCpTn6uezTqFjjEn+lLISzhbXW+q
	NydvoeIIi8FIC5fhoX2JjJRPUIhNFAjQ/
X-Received: by 2002:a05:6000:400b:b0:37d:4870:dedf with SMTP id ffacd0b85a97d-38260b5b997mr10052617f8f.19.1732533748640;
        Mon, 25 Nov 2024 03:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8RMF1eE8qGQ7deFZ6zkFBxZhw1nuFFo714Pf/H26XOtCJdb7eIMHcJamY8E6V00bW/7r8sLJJrO61LvbDfOs=
X-Received: by 2002:a05:6000:400b:b0:37d:4870:dedf with SMTP id
 ffacd0b85a97d-38260b5b997mr10052602f8f.19.1732533748386; Mon, 25 Nov 2024
 03:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108130737.126567-1-pbonzini@redhat.com> <rl5s5eykuzs4dgp23vpbagb4lntyl3uptwh54jzjjgfydynqvx@6xbbcjvb7zpn>
 <CABgObfbUzKswAjPuq_+KL9jyQegXgjSRQmc6uSm1cAXifNo_Xw@mail.gmail.com> <hbv5uf7b2auiwyjkekmtfpu26ht7ulvapnszx7rdgwoowqdcna@pwuuodkenwgr>
In-Reply-To: <hbv5uf7b2auiwyjkekmtfpu26ht7ulvapnszx7rdgwoowqdcna@pwuuodkenwgr>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Nov 2024 12:22:15 +0100
Message-ID: <CABgObfYtpW0B4uEmjne8FAq0tSJ+v4bvcukAgM2auuQWTqaGFA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	michael.christie@oracle.com, Tejun Heo <tj@kernel.org>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:01=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
> > > I think the bugs we saw are not so serious to warrant
> > > Fixes: c57c80467f90e ("kvm: Add helper function for creating VM worke=
r threads")
>
> I'm mainly posting this because there are some people surprised this
> didn't get to 6.12. Hence I wonder if Cc: stable would be helpful here.

Yes, the patch didn't make it to 6.12 because I wanted to get reviews
(which I did and resulted in changes), but it is in 6.13 and Cc:
stable is there.

Paolo


