Return-Path: <linux-kernel+bounces-407568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E09C6F23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3016B25806
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F41FF615;
	Wed, 13 Nov 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoOeYyV+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218517BD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500636; cv=none; b=SAtNpZj4/Hk+Gd4V4OM2ItCQm6jXoxanLDwz9OSkQnU0Ku9+ePa19RnTDXwXpjc8F/r/pwuY09mAwFsS3uaa3gB5lUkC7t/VvThVmtFHNxgNdPoBtQU5ZalDx8cVbMqfKL4WF7H1E9/lpReSzHNSFMPqUhL0tikcfp3qjaeM6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500636; c=relaxed/simple;
	bh=691iCJFmioydNSjINt6/WOMgqUtjBh2fMVuZtJDMJVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9XwfxXoJd1EJqqaDyAEr7aY3+6Zj9TJ6+LlLhIrGFWEviRyOCdYa53R4kUG1O+dC068K034DByUv97M64nLed7l3DSRjObR5MnsP/5UDEenmWPsfZodJaY35rJ8C7ncX2m2t33BrLxQ1A8iLfAKGDTJqieRcJ9QbV6qoOrBIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoOeYyV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731500633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=691iCJFmioydNSjINt6/WOMgqUtjBh2fMVuZtJDMJVU=;
	b=eoOeYyV+qu1m3bzVxGBEl9OSSi9jaANoHPx1ZV08gT7PRYORjVEgh4iSktMT5fKhEbsrL6
	ElE5ibrmcyMDsecT5X1G2eeQH4Bezd022QVwF2gYjfkAqiN1955I+3hZ5VoDXVMxNXzlkj
	tn8Moe43l+HLLfGfpdgb07qanEfvesU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-LT-6rnvmODi8yE67DUm3-Q-1; Wed, 13 Nov 2024 07:23:51 -0500
X-MC-Unique: LT-6rnvmODi8yE67DUm3-Q-1
X-Mimecast-MFC-AGG-ID: LT-6rnvmODi8yE67DUm3-Q
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-432d8843783so884365e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731500630; x=1732105430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=691iCJFmioydNSjINt6/WOMgqUtjBh2fMVuZtJDMJVU=;
        b=iAc98FnOyMslsLysFBVkKfTNgKX4iGHMeVkFtDqXyViEbDSuQU/C65+1aso58DWqTz
         /dqYOEuoPDYkfBgZry9i83N0swP1FqB8U9mJ5RJrtdu0CW0so9v24VHvdt/T5/S6kY+N
         uc+DYgiXrgqwOAY7Xk6ovsofxOAqqyYKUwRmWmX1jGPhZRLlmQ/Qed5pksPQxIg9N7Je
         FuHfmqgreTfbcF0lvynoYCjJo/2w6ObRnL2Oeb2w2f4iCShhh59iwTbXu7R26nnGv5Xq
         Cl/zhGjCMYhtEvtxo2qfza5ZUgBpyrBZiNHiuYytfwYjkZjYQrieL5joc34P2OtVFLZc
         2xcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAMwYQT9O29wekT1IqLYddyEEWWma6HB/iKzVMCdp414U0ThRQWyLQJ4LpCx6y3qLdecKl8fvUZzOaiaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbktGzv8GKOoQnqDJGRtL/0oyjoxS49MCwxbUOpZnK+rqzFBw
	ypTIE8DwkOkzYTU/2AaK2Td8iEmAmRnTJf+YaRLpYwaHPp42qaQp4Be0Ch/sKnWzUqP4V8RcUuZ
	68ykZ2n+RgBujKOvuDa8P318zztPDd711eX1srxSYNUCARw1WweePOnIO88QIlsICarKD4ehQCS
	nVA9WaxJHYKeKJ+iLBkIWnZc6u+jmkhn94VeKI
X-Received: by 2002:a05:600c:5124:b0:431:46fe:4cad with SMTP id 5b1f17b1804b1-432b7501d4emr183269395e9.9.1731500630721;
        Wed, 13 Nov 2024 04:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5w1uEWrW9uBfSXpu92W6DLFMUqwO7C+Qk7srcMFftnYjiG5WvPCv2OKiDxCTjbqhYn0ib1u+HRhKyEpTSb7c=
X-Received: by 2002:a05:600c:5124:b0:431:46fe:4cad with SMTP id
 5b1f17b1804b1-432b7501d4emr183269215e9.9.1731500630394; Wed, 13 Nov 2024
 04:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com>
In-Reply-To: <20241112193335.597514-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 13:23:38 +0100
Message-ID: <CABgObfaE6+uSwipaBUgVtYRh6F7RTyMPNYk=uRq1pTHcnOvMaw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 changes for 6.13
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, pulled.

Paolo

On Tue, Nov 12, 2024 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> AFAIK, there are no conflicts or dependencies with other architectures or
> trees.
>


