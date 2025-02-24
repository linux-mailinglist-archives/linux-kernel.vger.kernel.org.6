Return-Path: <linux-kernel+bounces-528036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E684A412B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9903A8307
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C34158536;
	Mon, 24 Feb 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWz7voKV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F51F957
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361204; cv=none; b=CUNlxFf3+wf1wgqz9rDXXR7qgdernKX8hRwxJmAeBM2s9UFtC++d6HIDEPdwrW0T2OA1x/vTyaqysVw3M7rxMongajPvuLzWdA9fM387EGxyfSYSPB8KxSJHFPFoeij7eYMSGb8a2NtQruf2t8GTYS4fRkzNVgBT1oWPC2EcVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361204; c=relaxed/simple;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Geu56rv0KTIyzHoLCkBXvMcUp/iAA28lkiuycAIzE/NpMZDwttvn6HNbRgSKOp+A39JHgmzTiq9aHs4Ejhb2CqwGo4HFEnd81NXkZviJEhH35kGran0oxCBZ/Wmsoed00JbcaBpCWCGfusbJXv7aXvcwhSqWmn7wJgNR7HPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWz7voKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	b=eWz7voKVGQLODjkrQFp+5h6kWAO3JeL05W8NLBlXU2KVPwViRdlXRQ1B49T+fxFVqKxlqH
	LlFtlJHrCWcdZx1LASKQawAa+7YqH7HpaRZ4paHIE9fuyqPhOBu2B3mRMdcklq5fo3hAq5
	cis2+ilDUcQc3MXPhg91X778y0Yw7yM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-3T9HfKdvNDmviB-Sws9UFA-1; Sun, 23 Feb 2025 20:40:00 -0500
X-MC-Unique: 3T9HfKdvNDmviB-Sws9UFA-1
X-Mimecast-MFC-AGG-ID: 3T9HfKdvNDmviB-Sws9UFA_1740361199
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso12897088a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361199; x=1740965999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
        b=uFzk9YOqGlIESVBoskDHVLJplQ+4BiGbaf20tLMgEfhN0qWrMTj5IXPihgfFiRtp+q
         KfW/BK3ra4fuJGOwOmiyFo9pd4D/Z7e3gxe0gJKhiqHuUoNYd96zPabIhxqPue6l1DNJ
         wT2L1f2VBPOPRxEFAESWyZtiouNmbwC3l7d4cbNapEQNS5FgrRmxCySCW0bkOPXOjhxx
         Cs+QAdry8QgnzbajfSMaqxH9ufq0tKnunin6YT21FiTEDRLNNlvE55t77b5RLf/XeQy7
         YkcKtLs6zCaD4rn6C0fHpumf/+6QxwHvfokvoqvqK2XwpZlRrriPPXGR595mihUCU3Bk
         yyGA==
X-Forwarded-Encrypted: i=1; AJvYcCWoWqTMO2GgYDV4BmukG+Ux0TfwEw2DWtHQqEN46fWAak4PDEfMmcLJeZQ7n7RfscYe+N5lGnx78M6vEBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCXFhEqfD1dePnCeVSqg6J4eCxSC+LA6dcYRAJ9LHmWB6OP4n
	y1AlaLbvchuayluVd8IzdcnnaqfUO73bug1fCB3A0QWtH+t287MVD4UDGtlVZUf+poyyyC/KODI
	JriKwL4wx4A/3Ee9Z1Lyf+Dfml8z+LAFK1Jh7339VlFae5AIiplC0O7cnPah8DvCebRgiwfwsO2
	dn50qbJSSqGw32utK8wL4Xs/wxNyC5AujvIx6UhsYU308aens=
X-Gm-Gg: ASbGncuAMFNXLI8E161+2txDiT//TDiRt4L+VBcbjUUfKskTk6l67HSOU9mj3m1KZAo
	XxWmVZkICnCk5N1ytWpkcRHH8PTawjYzD2b2ZdNKeeP3AAdunqo7jktVClJNk5fKYvr9Jv/0mhA
	==
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id 98e67ed59e1d1-2fce7b2c06fmr16130624a91.34.1740361198910;
        Sun, 23 Feb 2025 17:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGONcBxFR0n13Ho0Oz96boeVVOYPPhVCv5Oly5cUz/HAY7eIJGFtWgwnxADw9SLiWOkHbcKmlHWn6DR44VUsY8=
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id
 98e67ed59e1d1-2fce7b2c06fmr16130601a91.34.1740361198521; Sun, 23 Feb 2025
 17:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:39:46 +0800
X-Gm-Features: AWEUYZl6q3WmzRiZ7R6AyPCTyXoGgL2WiDIIupnXJ0sHWiJQL0PPi6nbPrX6XJg
Message-ID: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add back the previously removed cgroup function to support the kthread
> The biggest change for this part is in vhost_attach_cgroups() and
> vhost_attach_task_to_cgroups().
>
> Reuse the function __vhost_worker_flush, but in this situation, the
> attachment_cnt is 0. Therefore, add a boolean to disable this check.
>

How about just tweaking its value to INT_MAX so we can avoid this new param=
eter?

Thanks


