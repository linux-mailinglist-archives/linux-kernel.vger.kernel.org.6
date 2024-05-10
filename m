Return-Path: <linux-kernel+bounces-175919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3B8C2724
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6783B21DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FB171093;
	Fri, 10 May 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHMYKaIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A11708B1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352642; cv=none; b=ThE/7u3T6pXD862yCsfq2KcYlY0GNAG6Hf/yodKEPlcJWUBs9ziXwwYOPz51VBlXlD6NN1s0Qiu1A+7ceB/8PoA1dZX5mApri+L1YwBbPsa9xz2vlaAlGSU5dURtIi6myC5yyxqhP/RHhIqefZaj6+G+ghdOFvNZ/q6Rbbue8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352642; c=relaxed/simple;
	bh=6UpJsf7UyarweIVesoXQ1oPyfYbgvJZxUcn5M1EZCWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLbvOp0M5WKeF6031Rd6bB9U9DZiZWvZfaBnC/IRP3knx0TORhMXcfXZc08utEbOCB9OueJesTez/XX4jCz0GQ3bzUrIijxhbLqvGWxx1TlWYSG+FZcOLU8AQcHroEvk7hsb6Tg2RVV4DlzNWUGyLNdpUDTXjGgzF9UivX+eRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHMYKaIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715352639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J0ZSCx1DHXXQYVs6q7rCMNMDZdThCHrefX2O/j3bYQ=;
	b=XHMYKaIsEUcYykOKAiiepbut2ou2JvjcCu96QmQN4W2xXE6UY7qbBh6F6Weq5exEUXqEmU
	reTmsqe9S2fXMBtYJGpUR+HcVdv7BDO/huqdc19lAhgwHxDnAs6u3bcO+Q83sY+iMhqpZ5
	FGydOVoyC4MVdQmwftXw79vGqdiQZSE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-JQupMPdENVK2MwVIfN8C9w-1; Fri, 10 May 2024 10:50:38 -0400
X-MC-Unique: JQupMPdENVK2MwVIfN8C9w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34eb54c888cso1645141f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715352637; x=1715957437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J0ZSCx1DHXXQYVs6q7rCMNMDZdThCHrefX2O/j3bYQ=;
        b=qFodmqGKONYAYtr9/kMnw23dzr7u/uHXXL6z/dkx67yKKQcWH7fpuyEV+KtGbcqii2
         CvVQnkYIYmFjQOCpDJU09VXVskVXg1W9MvjWzHWj9lGiJtazxM/95M43daVbhAjzPhuq
         Q2beCWusmxFNY9gren/VrfvO7rb5QBzQznZ4/0kBSTczdbAkmzJy3aCp7D0SyS/9phb1
         Vuftr2wKkHoSh3YlPiWqft7/udEWzXbt1DduwNUWfLibcESBiG8CoGpyBVZipy1Nkyh1
         Q0t0cpVq+mHjK0BKS0v2vffbdzEOk5GDNVq4ZpMALI4Iul6DrmhCtM5dqsbOUQDpDaTP
         6luQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkDQBnQK6t/u+ZfPDy/sSm7W/IXqDzStAQwk4sTWHLcnNpG3VIoa5EEpzQ2NFk6LUaMJTiRH1/05KpujEc+aC/Zt2MpIyw/eKo+eDg
X-Gm-Message-State: AOJu0YwgeEmq67vsRk5TCMIFlcCtnQAeGgtG2GEewBGW0UC0c66rQcE+
	Eh/FHase31tfaZUld7BUNS/2iu/ALU0Q1L9jA8zWK+Rmdq7JEiAedvWIWK5s6vt0TabHR8LX/a+
	40402BDvxjNmmtM4m7YBaY+l0oP3t/yWq55PVA9B5imeXYBxwfSBpR5YrHVwSrqblSfXhENMWlh
	Ms4BKSiijOOkJ21kekEYU1uoqNICgLb0+sdS0d
X-Received: by 2002:a5d:4112:0:b0:34c:4d98:d6f7 with SMTP id ffacd0b85a97d-3504a73780fmr2559551f8f.26.1715352637037;
        Fri, 10 May 2024 07:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSIQotEMtylPZf743WE/QOLPBLsjbYAnMkg65qQbs7/jDa5Eg3h+x7J/bK/Rbl+YVAyOJn6KccrUXtbyh67pQ=
X-Received: by 2002:a5d:4112:0:b0:34c:4d98:d6f7 with SMTP id
 ffacd0b85a97d-3504a73780fmr2559538f8f.26.1715352636706; Fri, 10 May 2024
 07:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423165328.2853870-1-seanjc@google.com>
In-Reply-To: <20240423165328.2853870-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 May 2024 16:50:24 +0200
Message-ID: <CABgObfYYm_xwEFjNx0jzaVg2R6s1D5EWC2T6Fx-d++8=6nvm1g@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix supported VM_TYPES caps
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 6:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a goof where KVM fails to re-initialize the set of supported VM types=
,
> resulting in KVM overreporting the set of supported types when a vendor
> module is reloaded with incompatible settings.  E.g. unload kvm-intel.ko,
> reload with ept=3D0, and KVM will incorrectly treat SW_PROTECTED_VM as
> supported.
>
> Fix a similar long-standing bug with supported_mce_cap that is much less
> benign, and then harden against us making the same mistake in the future.
>
> Sean Christopherson (3):
>   KVM: x86: Fully re-initialize supported_vm_types on vendor module load
>   KVM: x86: Fully re-initialize supported_mce_cap on vendor module load
>   KVM: x86: Explicitly zero kvm_caps during vendor module load

Applied, thanks.

Paolo


