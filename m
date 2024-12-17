Return-Path: <linux-kernel+bounces-449220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D19F4C16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E743174A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318C1F428D;
	Tue, 17 Dec 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdKw5Q0K"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A31F2360
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440749; cv=none; b=CD9uFxDeiRgGrNRQ9MXF0oBdRQfXosY4m7jgYjAVRjD84riANSPZLwCW5KcRSRhwSn9TQzt1mpQ7BnU2w2c+k8yLl1lQyYhBeu3hS9Md3DW7PyLoK/gqJ0KZs+fEGhUCDO4WiP8fWeEWWfRNeTTAhGH37tmEetgY8hbCM+qFoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440749; c=relaxed/simple;
	bh=ESLSBuERl19IWMtBVZAhzvVsC7jbezB5GMfTsOfRYWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbY4JgKl0egT0AtIpeZgGQS246yWxjDZGK2/5hX6CWisQ13QpUWsxw1kIwR7w8DmbbBS0LaPoDD7SKQbLnEB1IaXwM0GhwP+fRkY3Xoq5bmi45Ueh+H5wsX9uDblqrZbNHe/9GbHsviijIVUwKJmFYvattgrgJIG3v7euxCMARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdKw5Q0K; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so816441266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734440746; x=1735045546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFIpSlbWhQWU4BmnuczxZhQrx3hDBfJmwoIXHjm0XOk=;
        b=tdKw5Q0K1D4MR85NdMy0JYzqdmTVfkA4k1+PBR5yCSOPkO4//YHg8OzxS5XWJvQke7
         E9rhs3PiFz8/24XlWLVI2a50otHnNFvyp+SobC6her82kTLBZCdID70O1JVT/74LgSzk
         Q04Zk3Kv7G9oFiCDxrQcWVM47wrGLgQFXdxJ8EAnd5gLYEAwRD1tSPAqs44RWulS1ymT
         GRY3hWSwjSrPUi4BnM1g1swBVfkBaBcbfM+8OWS996P3Z2xX1Iiwz3dmO6Dsq+oI42rG
         oPqW/3y+XChkD3IfmDtfH9ja4U21Ex/R+hCUI1Fo8ODqudFQOC8CkjvFP2vMH17GJU8z
         1RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440746; x=1735045546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFIpSlbWhQWU4BmnuczxZhQrx3hDBfJmwoIXHjm0XOk=;
        b=ciuJuU6EUXQGYREPrKR8HEHLVaaQ4jPj2OXITqN4Th/K5aKk4ER3ckI/ANd7jry9cA
         XRLNovstzbciB/Y7QssLUoM3QwMbg90tWi0y9AoPmy7Ta3FDUhKmmsqhiTYtZOxojKvj
         n3QkWINjGgmPIuf/EUt80bLN38x2VtaOFpTmQgkL/oPR3n+TFGS6B9Wvwdr2kTO+Zbmy
         GX5lE6ltDtVBShwTsqoxZI0h8GbV1mDk0W4TLQsQOenzqJgTU95Z/RoRoz6VCdGGgOPS
         nmpT1V0WlXW/GXMYwaW2+auqnRFc/r3U+GTnAN34xdmgAclizJnpIktjLmAiSYGTwEu9
         pawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGn8YeO/zaiATgw5DxSAwGX/vFCVYQMinZHJvFr0ogq8savNoMzHyUHc+glt8GFCIXMA/IVC7VaPS1yag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVP4knuYdl8dugwFVDJ1eULtFAz1bqulc63topQ/VqnwafjJ4K
	qMPMhbLOL9yKjqB2Ya7nSX/Z21FSDJ2yvy6/jBPJE4qwA2CvrqbTCu1sW4cb5Q==
X-Gm-Gg: ASbGncuwJmzVIMXRq/nB5fF1zd9BAnQjrJDOkJsHMT4qBSS6TOOzzAPZNEv/5cSxO2C
	a3owPkcoPbnEYS7GODgVT+4LxuPmkAXwlsJsGz8fYGEQCfaq4gKoEND02OG29Beu4Ef6t1rjdIN
	sA8n4l5rASkFB+8tKRGbeA8B4N+Pev5oeDm1hjT7DN01ClpubfTnaq3xm3Zm4dG7RoPjFvJMBcX
	BIecW1Qe6WFJ8wcb1j7wuFqSAeRa3pTkc7R4E7OSIlsmY3r9xmfFGDtSt2zZVQjOPjN0kJleNFX
	NWVWydqvbzFXyVc=
X-Google-Smtp-Source: AGHT+IGm64uJtVDjEAURcs9xZJG95uD+8LpWsogmwS7IwX0FntYGVqCsBRC/TY5BflaZ6Q9qsi8S9Q==
X-Received: by 2002:a17:906:6a1a:b0:aab:7461:fbe5 with SMTP id a640c23a62f3a-aab77e9c72cmr1588746566b.45.1734440745515;
        Tue, 17 Dec 2024 05:05:45 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96005f89sm446090766b.35.2024.12.17.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:05:45 -0800 (PST)
Date: Tue, 17 Dec 2024 13:05:41 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/18] KVM: arm64: Non-protected guest stage-2 support
 for pKVM
Message-ID: <Z2F3JZII0gh8iOH2@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <CA+EHjTz7=dRz5X-CjjniJgwd87Q4DQbRdXzi0on4C21urYnhOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTz7=dRz5X-CjjniJgwd87Q4DQbRdXzi0on4C21urYnhOQ@mail.gmail.com>

On Tuesday 17 Dec 2024 at 09:25:52 (+0000), Fuad Tabba wrote:
> On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
> >
> > Hi all,
> >
> > This is the v3 of the series adding support for non-protected guests
> > stage-2 to pKVM. Please refer to v1 for all the context:
> 
> For the series:
> 
> Tested-by: Fuad Tabba <tabba@google.com>

Thank you!
Quentin

