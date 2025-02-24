Return-Path: <linux-kernel+bounces-528059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D70A4130F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6035F3B58CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39B1DAC81;
	Mon, 24 Feb 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amZ9AZyt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36971D86FB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362213; cv=none; b=OVlHC3i5s4xKlLIJIakIVphfVY2TRsNvopsJC76QXohXw5WcKK6+cXljPdx/VgROyKefqcP61rX38RBb9dsGVM1Inx+ELkQWxsWL2xsgO/oeBZTvrU2FXsLWSAZMVKgCMVaf5tPCn33adLFrqKM8G7lvsG6HpSqrDWdVdBtHDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362213; c=relaxed/simple;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdD4ZiUs3oKY2NYJwNKh/8ynnevzQ3CN9fivWW6yUvFXTY967OkoK3d5wsq+rkeaH6Qe94PPQVbd1vuUk7eh6rdmcgcgLnf/4gKWk77zFLqrRlKelhAZgxq6ngBvBodSWWPkzzw4h/+idNQz6B3/h7M0q4cgczCEQVjieuESI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amZ9AZyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	b=amZ9AZytZvfph+ELQfPyTBvsQxQ6AFaNOzFbP/z/BZWF+bd6kQkFTTKxmfiIPqT3rvIWeS
	Ak/IrEM3PxU3jlbbthdqSuRmACnxMuJgWXWdGgORiSU6mSFk4t61R3Fs+6NdbQ0yN7fPoi
	k4/MGc5KaT0ykR5eeGPJPgDhLGO9X6Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-A54NYro1MbeOJv2UyCvJjA-1; Sun, 23 Feb 2025 20:56:48 -0500
X-MC-Unique: A54NYro1MbeOJv2UyCvJjA-1
X-Mimecast-MFC-AGG-ID: A54NYro1MbeOJv2UyCvJjA_1740362207
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so7637638a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362207; x=1740967007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
        b=tjz2WQhw/eWpTKVXZEgBu7+FBl0nY7or8m6QzR+eyhugxzhYmUJLrXA7+Do1aOf/kl
         lDvxBnetTdjSlExoAsQka9ZjUCG84Q6kCPo2YLQKE/KWkq3YKdzpJQAzlv6jgI0NaaTP
         N7P9yWTdCbkRP0ZdJ/4wqGi8421fFN3mE5ZX2qx1YZaBs8bIOWcrL7F1UJtoBkzkTcMM
         WyXxJ5mJ11uxg8PC/PCToWtgdN/0BDR0mS8sRRwLs5uYbjeBBPfROrGmPPmBxpRe7rKF
         +mFqXElO3QYYSyeO7Fw3dIX4wiC096+eniK+5YOUBQpHFS+iENyaBTTQxzViXiNdAN92
         nBzg==
X-Forwarded-Encrypted: i=1; AJvYcCUZFct+l/Nt27aVYaRVhbhxkrlauQdmNJMnbQriV2//Qd2f2Cw5EhUxrSQW6pzc5SCHLjRn8n7VgM8AHy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASz2+hjqiJxtGJPV8y7lS2C5HsAgZBAuwonkkyZaVUbU9YLEY
	+9Q5wRfaz45dFKkI729/e/XbHWCrn4bxq/UOn9U0ubCVOTTQxks7M97wpjd5exUN6bMyLTER3GT
	tpTND1OEQuhCpKb1+DX34sOP/y5DEYdCgEreDiOQW5IOBCo2WNLFhbmtuoNKUdmfi76MR+TH7Vn
	3tt9BPGlYd14O8tHNL+yqPdhNUdAx0qMXGUniu
X-Gm-Gg: ASbGncun+hpNvKPTdvV+IG2RmPYlkETIBvrfNWVtc6brQ147NFvU2aunlqDyfEcwRDC
	dzYJt0SKWQheheLx+v4XA+dhiDeAUiLuK0VkZiFLoBfrozUxOlG6zjOj4fR4CzDXEsXBE+VbFAA
	==
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2fce78b778cmr19847391a91.15.1740362207078;
        Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK9sEU4lgBSITBL7R7PIYPYfLCTP2jbN12H8uxVsQOHPrTrgk0YL/YWTUrigbXbtwUKlN+8N0guiwDqc1+JHc=
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-2fce78b778cmr19847371a91.15.1740362206706; Sun, 23 Feb 2025
 17:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-7-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:56:34 +0800
X-Gm-Features: AWEUYZl6ERtQHmg9Ng-G9gBzggonYtkd5NQ0JEzUKKMbmNT88IJbeaW3-Ohq2ks
Message-ID: <CACGkMEvf-WEuFUH7FwyM9w9Ay8qkz0edL3MHfGJa3CPkrzfm0g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] vhost: Add check for inherit_owner status
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to add a check for this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


