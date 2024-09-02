Return-Path: <linux-kernel+bounces-311680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C70968C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CC3B21530
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFF3BB50;
	Mon,  2 Sep 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma1A95pT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29955887
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294617; cv=none; b=sYnUqS9S0wWOv3GJcDVIi6HiXJQ9bLzw6opF0CwNER4xVhS9rZahUdPeFJ/FFElsRPV7rOzIPAn3PxsIWu0lRPCHYrMMA+Oy+wRyUhE2Y/Xbohi4gDikdyPYiaV/QdSCDAKz/FtwCk0hkzaeaxLzKzSba7Pp3S20NGfa3hkwnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294617; c=relaxed/simple;
	bh=y9rmIZUkhHhDge1AsTeRB/wi3YCOD8AGEoMcFfCtP50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxGNiJBORUzrbwqPss5YnK12fOGX0r4MWkSFOansAH30VOqZuB9DgbvGZzI/a2ZEXFyNa4xHXnx3jWaCgPohCESzHyrQ9wAPtKrNAJvFTSUFQJAqcDij3+mjuD+W6of+0Jm3eyBv9TWjVvYrcsV2N3D5J1vxQkMBk3OCr62YYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma1A95pT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725294614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9rmIZUkhHhDge1AsTeRB/wi3YCOD8AGEoMcFfCtP50=;
	b=Ma1A95pTArVSFqTxuDrl6ZcZ+h9VCEyi4Ky/mYTEbaI2diXu5mykJtrXaXpJCzvTnzIcwC
	IOmQffpFyYFgtaIltktyeLb575NTofUKHou3YuLobhPUS/89GBNwf5pEFQdRT9BfLkzjzu
	yZxWmt/yoZBIz7zXlecqN6zsO6ZWe6U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-_Lfwt3inMI66qbj0zJGMlg-1; Mon, 02 Sep 2024 12:30:13 -0400
X-MC-Unique: _Lfwt3inMI66qbj0zJGMlg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-715cdf0a53bso3217647b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294612; x=1725899412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9rmIZUkhHhDge1AsTeRB/wi3YCOD8AGEoMcFfCtP50=;
        b=ssi4G+H4buoACcBSgVJNNN1ddvDQBJ97WVsW7QTxnVko8Sp9/GJXp/WWTYnqUmODgj
         tq29X39diUe78t2H0uj1+zLHr3Ft+90yd3Lgpbus+geEKpFL3HL7PiwY0GWqu4rJaHXr
         g8v+pYCYqa/ywVuzuRStQBidC6jZXxhINJceFDBJWDrnNQRBJ4uhSxt4Lh4Reg0gbPIX
         OLJ3EOR0M02HqN1IcbDs2A+X0qR/1J1tonNzj8S9fLYM1tSaraouk5TRkYyEEpT+BxMW
         7boGGi3DrmME9aC6mv5La6Nrz0yVVY0Z+5ZWZm1kXLYb04rCuy8DoAc4Lo4rfsHdM0r1
         UQnw==
X-Forwarded-Encrypted: i=1; AJvYcCVjO+0C47H0FiDkyDHLYQMed4D+l61oLUwEb5JhFVj6leoxGnyVGSMfRY/L1qJzV4s1Gsjqf2mBRuWIPXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWHuNCMUTyGXyR95PnmIAx+yua4TTCJHJbC+hV1pMSbWZKe9o
	p8FWefPxUk53Wbfc5xFdVbfiyIZ+fpM87J0OUI2svKLWkrH7YuWGXhlJGl6zHpSvS4iz46PRMT6
	yj56fOeQ3ebpOGKbUANlfe+UXzlBsvTHb4ttxJ98i92qBjdziIaoYdlJtyWc+6yNKr2/dCZwG/t
	YVCSXdK2Q89oWXhQWKWjAnjULSzAJLTjTFBNso
X-Received: by 2002:a05:6a21:394a:b0:1cc:e4d0:84e9 with SMTP id adf61e73a8af0-1cece50235dmr8036827637.17.1725294612297;
        Mon, 02 Sep 2024 09:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoBISUpaETKmXWjYLMX9OvXWf6NhGf8camXMY3dXDdiY//ktjWVoWIvLx/zwhZ290M/DMXm/zvrJoNfltI2Mk=
X-Received: by 2002:a05:6a21:394a:b0:1cc:e4d0:84e9 with SMTP id
 adf61e73a8af0-1cece50235dmr8036803637.17.1725294611883; Mon, 02 Sep 2024
 09:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zsb4kbq6FAfgg4WA@linux.dev> <ZshONupF3nIhAlRf@arm.com>
 <CABgObfZ=P-Qc20SD=duFtDbCefWGO9YoEcA=S0DaTo59x58iYg@mail.gmail.com> <20240902150725.GA11571@willie-the-truck>
In-Reply-To: <20240902150725.GA11571@willie-the-truck>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 18:29:58 +0200
Message-ID: <CABgObfa-hR5Xx5ORXAhTmvxChK=77WpWhD5erWK=cz1MTZoJsw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.11, round #2
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:07=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
> I think this was all pulled by Linus over a week ago:
>
> https://lore.kernel.org/all/ZsjE6BXzDznbg6R-@arm.com/

Yeah, that's what happens if you "git rebase v6.11-rc6" on the wrong machin=
e.

Paolo


