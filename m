Return-Path: <linux-kernel+bounces-184044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012E8CA1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EFE2809AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C24139579;
	Mon, 20 May 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TCdP5co2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73D13792E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228120; cv=none; b=Rr4UE2BiWE01YDSINsj+kOYz4EPmdFTeb0eV/gsPJKKFvRa1hSxQaw9MQa68/o/K1rc0AFptPhakA68cX6qrQUBH0bhx8dEaPDYHdBeUqe5k3E2AsjFAe093Bxgl/XqHn/Qfb91DKlWcz/Bd2vjbBu+DhzL81zf/6GaWHjlKt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228120; c=relaxed/simple;
	bh=ThAtV8/RaZOXL6OfIQr7NqoXcDo+g2hyeB95dXoGkWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQCjrYuycSM1BqTjn4vu8omEfzIs/xI21+Ai/pqlimlFCAUC/TaPgHd692BZn18ZdCp68Tf5IRwbXxhQnj2KArPo0enx8j0qOnQ9rD7GZY7gcZ4Ag7l9XWkGTVdKce/A/uyfhx2mRXPJqBOwjC/y+6V7+/FEd1cCNpJj+3T3NDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCdP5co2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso17367a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716228117; x=1716832917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0EUk3VTdFf3wR/+ltNitT6ijh9TI5cz0EzrDG2fXs8=;
        b=TCdP5co2eQ2rdnIZY5X77YfUyGK1xCrAnnTArpWzcSmQrc9lLMZE+wrrnf2Hw71+wJ
         /Xkx1NzNYxwPtBPSlDzsT0NqUaq8DWF0+MGrvzqo2XWkEZBdXV85QEnTZItU2OWmLrNR
         24reGxLIvFdCFdCOjDXSCs0ElzlGtyp3MCRR1Re5MK0YFfHpsG2lG1AQVHekie40bQXW
         DAz72bsgGDqeNRqVnXxK1uuqs06EG+1ZDMJKg1J8PLsZqIzHOWCO+915sioc9oeS7KiM
         fhOTpUVebzyFdrb9f3OP8BUr+2jX+Pbl/5WWbg/oCquNDBHEFtxhzVPi1M9ObvnbYXe+
         u0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716228117; x=1716832917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0EUk3VTdFf3wR/+ltNitT6ijh9TI5cz0EzrDG2fXs8=;
        b=DKTvZ+7LHHc4CiVn/hxN7cot7tVaradc/KNVpb0lbVBMqXqEtkihE7hlC4eGqsNeF8
         pmlLZU5aZDm6XgGDrDa0MVx3OfTIyRHOx5aL0VG9WB4JTfMhe95yltnv2U68uvVOuQTZ
         j7bd4N8Z02ixvPGyREnVmiSfpvPNtIP/0olWVNE4bLLkQ47VCl2xHJEyJTPhmU3AftMe
         8nshenHj6fpSD6pEPi8hQTmCGtWFzZkULnS1KrYvp6OaLH/lTw7N4w7DuHipIK2cNHxE
         NlRvebOovHHDeICZLuMxYgl+Jv9ygF3BttzEZd+8w3MYPUGbDrBArzs37LvcPMPQVRa7
         JynQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6vjpu/dGDiFzoQNPyAvkBLTOoE8e+h0EFPDESnqyyq7p0bZGCEZCYiuZEtkAYII+dtGR1FSZae/YRT2h/+aO2ifgDQzoYqjumxv7l
X-Gm-Message-State: AOJu0YxZ+N37BHQWyxHt8MRCVm/KJIOXQZpW38Wdo0kWt4ZEpCP/MEcE
	LAxSS3wDt1YmqURROjcADq1X2D1OFBfedfGk5n0NCEdmldouCzEh0ZoSkjrs8bnSsOwuxepD0pS
	UvVUwq6k+iGRam+cGWa0WoDEcz0IEMGhrwIWfxNwxgP1x8nLl4A==
X-Google-Smtp-Source: AGHT+IG8Z+2iw7xGf53mN3w/XeVsWFWYzjQGICvUQj/dAcfHn7ngEhHO670hpW3XjQ91xph7K4EZbEyy9S8QX1yXaPs=
X-Received: by 2002:aa7:d39a:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5752a70fc1cmr324926a12.2.1716228117191; Mon, 20 May 2024
 11:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520175925.1217334-1-seanjc@google.com> <20240520175925.1217334-4-seanjc@google.com>
In-Reply-To: <20240520175925.1217334-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 20 May 2024 11:01:41 -0700
Message-ID: <CALMp9eS9Nani-jzjQjfWyMS+gQTrH6XHn588EMpCPQoug-Gaww@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] KVM: x86: Stuff vCPU's PAT with default value at
 RESET, not creation
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:00=E2=80=AFAM Sean Christopherson <seanjc@google=
com> wrote:
>
> Move the stuffing of the vCPU's PAT to the architectural "default" value
> from kvm_arch_vcpu_create() to kvm_vcpu_reset(), guarded by !init_event,
> to better capture that the default value is the value "Following Power-up
> or Reset".  E.g. setting PAT only during creation would break if KVM were
> to expose a RESET ioctl() to userspace (which is unlikely, but that's not
> a good reason to have unintuitive code).
>
> No functional change.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

