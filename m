Return-Path: <linux-kernel+bounces-176810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37738C354A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50621C209B6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438EC17758;
	Sun, 12 May 2024 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIKGaQuz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B417583
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498374; cv=none; b=WCDUe3cOdpH7WYhBVM38ax2rrIZh99qPknQmop74t6vvNa+cl112oMNZNd3BSwJNE/hUd+T/mj1Vqog92hwGfwF++vIxQTCopn9bdoqIbFKGzz3TziaSMvKawsmnF68DB0+Op50ahYOn8IdqnYEViEmiaWswIAnunpeLK1sHUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498374; c=relaxed/simple;
	bh=SjhuRfJMuyO7GM96jJNtrPoACgPadZ8CofQaX4mKANM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kn2ARskJ0gnQXeDlcfQ1qth0QahqSxq42E1dQvn43YXTGWUEA03q5hx7rJVqThlyStlt7WjV7NvxFwq0QH5Jxtg3GZHF1jxYbqbyPNkskuU02AjmNRN8VpuSec+FRjHHxUsYu6AbK+umQ/UF1QNsa96kx7H9g3/+UfJoFMD75x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIKGaQuz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715498372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjhuRfJMuyO7GM96jJNtrPoACgPadZ8CofQaX4mKANM=;
	b=bIKGaQuzwq825FEUOwZ2/xVG83Pzr3qZ8EkTskcttFOmFqq2kW1ufNT7ZvWbErWAv0SNGe
	YNY3WRdAd5uaZfcGIuM9aug3z2/AwROa6QsaDHzEfa9DxZQxnb+/tvDednUPDlx5WXWpuS
	+0H+8cAWbSOaQRi6+gqkJQeE09VCUBs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-twruZD_lO9KAWHwjmqGuEQ-1; Sun, 12 May 2024 03:19:30 -0400
X-MC-Unique: twruZD_lO9KAWHwjmqGuEQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5206ef0d6fdso2927899e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 00:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715498369; x=1716103169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjhuRfJMuyO7GM96jJNtrPoACgPadZ8CofQaX4mKANM=;
        b=oCQyzAru6HNpO8v2QQcfoX3x3/h+vNNGygJvpxRTTfc52E/+ncIvWcrxAt3eI4GCPn
         R9u2Ee1o+3T+zVftlZ4RvOaZ/ekO8O7b73h5EPsLptidgDEufpux2uOknrd92EPsRl75
         GTvyKYTfStEUM9XNAlAz91jRj6zJleFhUR3f/DFScw1fEjhy65tyWrPvSfMrRrNgvaUz
         0Zflk6J28mEZ8oHt0ddsM8/wO7neTP4LoKbIDbd/ClAvtAe0qHMP9au3Gmngh08euN1R
         xGwgF0VNykJHzEzOrm9wgw336sO6oiDhrxEggG1hJDDH8Otib0pPQ6dazhGOBoMrH7/I
         zHbA==
X-Forwarded-Encrypted: i=1; AJvYcCU92W5+FBSesXO1IDc6gzCRoyDSk831YI5cq017gCjHOwYqQ7gOqYRdg/wVnrbhH/qOtQZBqlQ8kVSNMd4FenaVNX4oJBhVtEI1YBZ/
X-Gm-Message-State: AOJu0YxqsurPDKSsLXPiCKdWOBOO+5Ozo3eFRk3lTjhvXboE4LQiTxzV
	CD3wIHbI5EF39Z58BJRzBdHPIWTHhcCcJwjW1MSO2z8nSoWKDKmUT9k1itlQJ5Nn3K8bAAFjT57
	IkhsNoVW2iCUngQXA5y60XwgWqIX/6DuP/hFYVcQ86EKhJtdCO3ctInJ0gtPlk0lkIGn8bHtmZH
	D/ehBvDfAPSiwYDxCOpoyJ3TMM7z/Isv88m9kG
X-Received: by 2002:a19:770b:0:b0:51e:f8ae:db35 with SMTP id 2adb3069b0e04-5220fe798b9mr4043007e87.43.1715498368840;
        Sun, 12 May 2024 00:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzsEg1aJ25kKXmalZ4iS95ClJKdZVZF8uHKMumVpfk3l28kpvTcd6c9CIHX58M/zdIrqZBVfHzmNsuYtTNFMA=
X-Received: by 2002:a19:770b:0:b0:51e:f8ae:db35 with SMTP id
 2adb3069b0e04-5220fe798b9mr4043000e87.43.1715498368440; Sun, 12 May 2024
 00:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510235055.2811352-1-seanjc@google.com>
In-Reply-To: <20240510235055.2811352-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 12 May 2024 09:19:17 +0200
Message-ID: <CABgObfauP2zPdhK65uVJb92kwp7TBve_8n7AE2Hhe9sQf+iNZw@mail.gmail.com>
Subject: Re: KVM: x86 pull requests for 6.10
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 1:51=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Nothing notable to say here, this mail exits purely to be the parent.

Pulled all of them, thanks.

Paolo


