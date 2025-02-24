Return-Path: <linux-kernel+bounces-528035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A253A412B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02763AA1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938001624C1;
	Mon, 24 Feb 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfN7SlaO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580C802
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361035; cv=none; b=TkHNtWFbjkk0Ok09gdK4rjvf1zm6MI3mthVAftnua4HbmX2qIXmI/y3P0bB6fofOCnBgA2eNsjcwbflbOgl7mz4bXZUDSPI6j8tnao5g4X/LvMcuHplgopY2SEZVs/HFhCfUr//xo6b5Owq1yFKkb5idNMh2k3Gk/0Z+ZBS1nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361035; c=relaxed/simple;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkhXjj7u7Si5/d74IQ7z5xWREwJ0Hr1IxvDN2ePHSDmYlQmDZ8qgVZi9gSA0850SKtWpi0ZrMXVig1Apjwm6A5nS/VzGR/7g1KqtTQ70fVfh6p0S/xHhDBgvTvX+NLoghRavc4uK+s2C76gqXVB9dAwR2qTFXSU5Ml9886erwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfN7SlaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	b=BfN7SlaO9AVWCpDb0a8RQZOpw4cHvj3xpMrvFcbOUmj8P4Bn7Md14G32g+82Vdjc3Wqm6J
	jzlTRy4O497hWti3rtRIZaH1I17ZS1Y07/azxGqbq50AoHcr3m5azNB/KnBqWa1xhLupG6
	zvFjV9fznR+XhvE2FwX1/rqMk9aoXT0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-VFVOeIhdPpawHjZMAK2HeA-1; Sun, 23 Feb 2025 20:37:10 -0500
X-MC-Unique: VFVOeIhdPpawHjZMAK2HeA-1
X-Mimecast-MFC-AGG-ID: VFVOeIhdPpawHjZMAK2HeA_1740361030
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220ee2e7746so78596835ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361030; x=1740965830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
        b=Y877VmNDijzjasubZCX9KrAaNciNvRKRvSnjI9bU82MaqF9Ud9JH6l9/o/+46DAQ4r
         Zy6NCoeRFvRiWS4gP9eG/WgNsVxxhYIvE1dLLl8Dl4KfY5VCIMQ0HJD8+9y6SAoEzCfC
         igIJ/Kh4URL9ZbPNfjrMTuCxvKHLoRr0WkqHcZzCB7tDMJyu0iOXa3vwANmXz5yt3mt1
         E3GuHEXWN1NsVvhR9wYBggPp4DLre+ynEPgGpFSbQnudn34MoVmVbnTY5k9TQEl6KGNx
         mNTgD6S/oJzvC7VOtQH6ODiRPw1D1dQzb+0P3zJY3pBWETZaj4RUZFvOZtfvz11jeF+2
         G+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCURjga8Nhk1Dx7vMvyo5aZCT77R7oXsy98N4kG3POtFJUjjyQjFiSN6WYailIvq4SSDNPPH3JxQ7DrhDFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvQ5fcuXKbM0cEvl/jxbtvc+4BJ+xwuU6Q6oXXuJpjDzjQJFQ
	qyaWA4JlsPikUXGTXud9SIdEWJt9lHrdUxwM3S+J7PnxT0Fofn/suWPB5WwZ1oxYyc1TV2r9mmB
	exJy65n6YI904IKXSj8e/nwZivM3xh0G7/0F28GxZKo6SFV1n701f1XjI8i+yM3PlVRz5SZtbLZ
	5iA99kdTGDGRVn5yDiRgHsbjWUDOt6eopb8Uyh
X-Gm-Gg: ASbGnctfDj8uZdG3FPuD8W+iFWazD/ne64GomwFbajIDa5q5LZzUUphe82g0e8DrY3r
	B7lPCyaV8d0mPp4W3l01ZvCd8zh3mULPrp0jhDT3Quk148EbfDQmFA1qIO2MWomv+nlhbUjm8RQ
	==
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id d9443c01a7336-2219ffd270dmr177749695ad.38.1740361029791;
        Sun, 23 Feb 2025 17:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOeXKHHqb4Fy7D0duuUsqaBjQ5JEjIFblCv4/RR6Cjx6kySGlfKNdzXcRttM48rlOR+pU3OSFf2tpAQIg5Gho=
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id
 d9443c01a7336-2219ffd270dmr177749415ad.38.1740361029317; Sun, 23 Feb 2025
 17:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-3-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:57 +0800
X-Gm-Features: AWEUYZkUhaSykDfVeHI8T77xwBRzCjQxyzGy4NNFOVme4_LjDEohqSIX-n4QmYY
Message-ID: <CACGkMEsmX7v8ta4D3vgzi3S=G9nzjmTs3pG3FBou+2mNa__vpQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] vhost: Reintroduce vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the previously removed function vhost_worker() back
> to support the kthread and rename it to vhost_run_work_kthread_list.
>
> The old function vhost_worker was change to support task in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> change to xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


