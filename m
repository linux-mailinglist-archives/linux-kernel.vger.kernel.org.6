Return-Path: <linux-kernel+bounces-274800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC43947CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B40B22343
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB413BC26;
	Mon,  5 Aug 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIRVjweW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2413AD29
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868361; cv=none; b=LAublyomExJfhAoMG8Bl0Iwx+opz+SsIQ+ruGhLnpzDgj0BZSleeIQfyi2RUbI1VS/rfFuggRoj+onCsfZNBnfivnk+yJX85w07/xeaZ4ty1H/K16MMWdi1GjhNzblSwyZWt6Tf57kew1v1Ac3eR1Yzpcl8gSVwxX0VfDoP+IME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868361; c=relaxed/simple;
	bh=sRV3gNGKH7pTjZDg3VbBocrQvihX8mBkN6lBnuSXmCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0w8OXmnFsMz4v2E0/LMOogTWc4GYlFzvTEyelKhwkBqawIfHKqqZ8LpcI9q5nqULByIjfu8Ou3tkIVbmSLc3Fc8wh8BN3GNlxckttkbfR+aRs525Zwqj/seyK8AEiBUmMqMXQ3it1dzPX8GJwgi10KGx4AFwtSQgh0bqA89Bx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIRVjweW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722868358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdhTzHGWfeUcTZeTuwS9gAaX+TnljxG1Ua0SsTOdngA=;
	b=gIRVjweWdvpVZtAmVOuv3F622g7YAZLczKf6YLginut7i0yKeAMX0noPnOdaGdxDSv6vYP
	IpM1HUfKOgYMWIPybbPOa+0mpKYPH5sri+SRlgd1hagnO9Tk9/J9nqziV01TQ5hk6omX7O
	qOYV+idqrjCwkmt37baCZrVXTwzkzGM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Rkl6z7ItPKSmr9uSQg-XjQ-1; Mon, 05 Aug 2024 10:32:35 -0400
X-MC-Unique: Rkl6z7ItPKSmr9uSQg-XjQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684ea1537fso5398196f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868349; x=1723473149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdhTzHGWfeUcTZeTuwS9gAaX+TnljxG1Ua0SsTOdngA=;
        b=L4wERZm06uSpiQoX3yViv65ohuCu/ERL86lgF8OO0CV2OzuxYCUZDjgBVlE1KBPnuF
         rpeRbAVNbFxmdmN8LAHgEuZAqpt6AGsQEXVWoZAHvIPtpHeC4OqbKWv4K8hJ68AKasGE
         V7hvm6HgbD0RmILuIh7GvXgHlTqO/Hi5EFPU8bjZjH0MknGOkunyMAUIdsiQNQ5aDUNL
         NrpPOo5V/nZUPHOjzwpoUOId+tRVwSJg+ueddcx1IaagRfUYohep2w9wyXVLb6A7DOGa
         k2WwpDew8b0eHdu2g6S6kPuU2e1XTYuz+028CuE7PVoQR6ZghHZCrLEVfeqv5grAeHoG
         h9bg==
X-Gm-Message-State: AOJu0YxjwpNklqCAEJGsTNsIbCcyvjb6UwAhG5CkibZH7lCQspo501+N
	+5qLnUgDC81/sgrHHzwslOEqvRpsgvMDCDK/dfpPkxEJSR5DQVS05mb0skSXF9hcr2MutwUE/LE
	5L95o23t71bExvRVv3+u9Yu9tNNNmOp1w/meoxh+JhOpUJ37F6WDfFxNmUKDSgDyHD4ZBClYwFu
	U6PXzXjypaku9jYu1S5E/n3Od9OVCeJmWTbAT2hpDDpTT29tQ=
X-Received: by 2002:adf:e411:0:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-36bbc1c34e2mr8371251f8f.61.1722868348829;
        Mon, 05 Aug 2024 07:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC4uxjlocGuHRe7VMvIPg04UbSdKvFjwtiJuSX5OhGJwtx+TNuYq7IjhpmnKZKsaje3hiJN6zXGMH2DXCKuGM=
X-Received: by 2002:adf:e411:0:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-36bbc1c34e2mr8371232f8f.61.1722868348409; Mon, 05 Aug 2024
 07:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801235333.357075-1-pbonzini@redhat.com> <20240802203608.3sds2wauu37cgebw@amd.com>
In-Reply-To: <20240802203608.3sds2wauu37cgebw@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 Aug 2024 16:32:16 +0200
Message-ID: <CABgObfbhB9AaoEONr+zPuG4YBZr2nd-BDA4Sqou-NKe-Y2Ch+Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: allow KVM_SEV_GET_ATTESTATION_REPORT for SNP guests
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:41=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> On Fri, Aug 02, 2024 at 01:53:33AM +0200, Paolo Bonzini wrote:
> > Even though KVM_SEV_GET_ATTESTATION_REPORT is not one of the commands
> > that were added for SEV-SNP guests, it can be applied to them.  Filteri=
ng
>
> Is the command actually succeeding for an SNP-enabled guest? When I
> test this, I get a fw_err code of 1 (INVALID_PLATFORM_STATE), and
> after speaking with some firmware folks that seems to be the expected
> behavior.

So is there no equivalent of QEMU's query-sev-attestation-report for
SEV-SNP? (And is there any user of query-sev-attestation-report for
non-SNP?)

Paolo

> There's also some other things that aren't going to work as expected,
> e.g. KVM uses sev->handle as the handle for the guest it wants to fetch
> the attestation report for, but in the case of SNP, sev->handle will be
> uninitialized since that only happens via KVM_SEV_LAUNCH_UPDATE_DATA,
> which isn't usable for SNP guests.
>
> As I understand it, the only firmware commands allowed for SNP guests are
> those listed in the SNP firmware ABI, section "Command Reference", and
> in any instance where a legacy command from the legacy SEV/SEV-ES firmwar=
e
> ABI is also applicable for SNP, the legacy command will be defined again
> in the "Command Reference" section of the SNP spec.  E.g., GET_ID is
> specifically documented in both the SEV/SEV-ES firmware ABI, as well as
> the SNP firmware ABI spec. But ATTESTATION (and the similar LAUNCH_MEASUR=
E)
> are only mentioned in the SEV/SEV-ES Firmware ABI, so I think it makes
> sense that KVM also only allows them for SEV/SEV-ES.


