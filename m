Return-Path: <linux-kernel+bounces-385820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED189B3C25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FAD1C20D20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649051E1043;
	Mon, 28 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sdtp7gg1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB21E0DB6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148336; cv=none; b=tUm3+fjIf1bVhbacFvg3ghQ3sDfAyRIW147rpkM/FBBTUR4g2KuWcQ+27qUL1j1sfLGP9SCapiB1OeYyrzGY+9vq3nn5xvKeoSNeY564l3OzBLKao7iFey9JBCwzwbDj+QUtYsuuOrL97ac3Xxo0yg78orFj168QHVRkPQOFAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148336; c=relaxed/simple;
	bh=ZpZwPefGlLKwfRcQr9eo4d8WzScWyn0cUDZORUV6UrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZTvAOpwzApeD4OVikeq3Sg9duG61iovbtNMcyFaw/X0pyVmnbMVsAISpJhHpTTR1D/rJUzkIsFCwHw31Y5sPciFPUA8fo9XTD/C5RZZJx+NR7yyl5TPQsz/Dr4MogXXgXRYNj3+nrQ1UO2nWATgyl0crfWNmpm6ea2R8VBtiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sdtp7gg1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so69815797b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730148334; x=1730753134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKuNSIYTBR1rDIPTuHwqfwMTGhTV2i8TmyskVsFOfO4=;
        b=Sdtp7gg1kWBNaiDICJOhK8EIFucDOlbwpFkXSsdWnmMsNXFOiVI6WE3q9njpooR9kd
         +gcli4zhdpbze4BY+QX0usr+4UgQHALE+u5l8CQ4bj1zFIb1E650WhubM8aICW+jzVlG
         Zdt07jnU+6ke7v6OZ0+cdFS6/EkYnibrrgFO4Ao0oNUpRHdwLo1P3gWpS8GUgT2i9oEq
         iuY84IFJaNm+EuIlHySvMvd5SrLubpuBfBby+ZsZjJI0tNchwzUlNyJydcf2/owMi9nR
         K6TXRrmbpghcRvbd17XNbSQ7ZH4HvYq6MlByda+NwleB8yxEGmG3NNONDCpenpkZkxXq
         MyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148334; x=1730753134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKuNSIYTBR1rDIPTuHwqfwMTGhTV2i8TmyskVsFOfO4=;
        b=PC+d4JGGogXhZtvxxIWlF6oqBVwfP8CB7qKtW/PEPkZa+XJSPVYfBHTARSYgd14agV
         oOhpcE2xgKGh2W/6emCdgmOv+yX0KfCSF55S2rt7ot5rKQrq8nHamZ9SD3D0MxVyjuGw
         dOaN4U+3wuI8y4g0I7BgyPYmmXqFnyk2UaykPSBS6R/9uEGpJLXHxCAvOMbUpODXUYUA
         /gkszpSoKNjy0bU3/XFY65PMEIt/2wmP4aPC3Q5nmlYR+3aHQfZmVmJLTlreMYpMtWmf
         /YAm3bjZ2RDYbNUxrLac3wLO6GtHKFenfbvC3PaOznRGWPDKrs851pyJ7roNqK9uprP/
         6TEg==
X-Forwarded-Encrypted: i=1; AJvYcCXIDUbe/4B2OSYW8ThMEt5ldMmYXF/yGwqGuWQ/iA3acdB4GUKNK6FYf5DYywUvpIYL4cpLeEKwfkF4ZZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/da8ZiNvF5oU+AY/+CvVHcjlnHWe1FAemQl8GXCFQkc/C+iIa
	26rUTfWM3UYmnAaFbJwmyqW/WAYaqVmjKpnMlxPZy7YZTz1bHbOENnmjHFAPBYZrPLifbat3Tgz
	2NQ==
X-Google-Smtp-Source: AGHT+IHUv/Dlq02qbqz0gjBFFfL25anLHCsRNYQi4mL1loTc7X5gbHLuxRGm93NhBDNRsTac4zgpo4TCt0s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a5b:d43:0:b0:e29:7454:a4da with SMTP id
 3f1490d57ef6-e3087a705fcmr7090276.4.1730148333867; Mon, 28 Oct 2024 13:45:33
 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:45:32 +0000
In-Reply-To: <CADrL8HUEwnP8e700y2XYDgVhhUJuj1UEJmd2NLdtZ1dV845DNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com> <20241009154953.1073471-10-seanjc@google.com>
 <CADrL8HUEwnP8e700y2XYDgVhhUJuj1UEJmd2NLdtZ1dV845DNw@mail.gmail.com>
Message-ID: <Zx_37E9QY_PfBaTB@google.com>
Subject: Re: [PATCH v3 09/14] KVM: sefltests: Explicitly include
 ucall_common.h in mmu_stress_test.c
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+lists

Unless there is a good reason for off-list communication, please keep the Cc
list intact when responding, even for trivialities.

On Mon, Oct 28, 2024, James Houghton wrote:
> BTW, there is a typo in the shortlog: "sefltests". Guessing you've
> noticed that already.

I had not.  Thanks for the eyeballs!

