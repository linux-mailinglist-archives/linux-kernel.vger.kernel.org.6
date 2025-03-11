Return-Path: <linux-kernel+bounces-556444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5BA5C8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F5D7A964E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2325EFA5;
	Tue, 11 Mar 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/G+6qzQ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46123817F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708341; cv=none; b=LNDPUDY/pAFcwc53HOsaa5uLPi87EKK2oN/tdo1xz4FHbkGYioHP/TAlK4KYFRfAhK03xbpT2CqejeTUb0PE0EoYIjRCxg2cCg8P32sb4mWRTykhkLDU2l9XwpqaIVtattdu9SUDLpopCyrdfjZCiqrkF/lIQaiEZmsjXBwlaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708341; c=relaxed/simple;
	bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSblq1PAAvaIaeh+6ewDE59Z3xwBqh8PQ6anxGaoetWW4kHE67ENq/61Er3KyUWLbJmNeC0SOthU+F38yqUAEMsEg6KEREO3O9tJDhrr0Ue5gxeXNPhBthY5FC2LT88mAhYWZTAsFYz9puXP5klRxr6qvuzwwFlEHHdsYzg25pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/G+6qzQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so166705ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741708340; x=1742313140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
        b=N/G+6qzQj9efsSOlzH2HUFvD/ARfDMV4YbVcVjcux7YJhL31LYz8HkxlikMgLkiNyD
         S7MwpI7+RZOYL3rJQvHGqijQZVIKEmpvV0zUcQalGixsbBoQPD/R32qZJtNFF85+F9Fz
         hR3m2MelSMtdeTW8ZVWy/bBbx22pdLu3tIf2GKkiUDRFq/1GsNlYWjtBl1TWGF2C2K0m
         ceig+ALiWR+zrhH900jXFNzS94RnMIq9gcV4OrjTrszD6LSZvyawKT2wHEEa7I1yiJp4
         Hy2QoVwWcId2wZSIjbS8hDxwVbPTFTsRPDHC+b0px1ldvmeNcJg8tVGpqDdwbR/THPvX
         BNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708340; x=1742313140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL53cvzxros9FXAXsrpO2xo6pNw4mdFJ29wILmBzP2Y=;
        b=BVmMAwRSWazpH6hl6GtTG8Mdy39oxI0LQF8r6z9SZM84Z1bM8kNidAOxgv2gaWjBIG
         RwAenjWj1ZU0rIsEmXogjhQSzaAGgaz3CqIp7+oM/SOEXFEF5+ciaAFuwlpmBJUFRUGB
         0HsF6tVyi/HtZf80Sq0ukeE0XYgBFIlPeifWEHbhbN2+607/m7ftXEeGSb9Wo+p/Z5ee
         d4chv5Ev10g/0qok/kyn12PMMzqjBpUD3uBOvaBBc2pAJZbbGS2jOtkg1JTlxE+MevyU
         fPOOgJrs1ciAMmHsY91zQyOO03b+4CRIqWWEnkqRKzB2L1wbIVM9tGv6SKD/mz1ZZWlz
         QJwA==
X-Forwarded-Encrypted: i=1; AJvYcCXnVubOioCNgbfpk+brML8bKq69MpMrHqrRj87khaFaJc77u/FXvII422y1Bgr9tORLbJvz1HbY2FgpoTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+2HL/idDAg2plPXTqi70bS7DJKxYnyh5px2xbprRLiVLdK6F
	aeOXbEbHsVGnY2DEX6uSzPKFJ+6d0IVMD6S8Qwq+tGXIMJ7zjQq5k7mJJcZTpezkWqQgrztcL0U
	fXta35p/mGkve1TNfDTjpJNC4k0vjEGN9jzuw
X-Gm-Gg: ASbGncu9ZJAP7bmRCsvglBP8BsALvnLLfwyVeOnool8WKjeKXEYeY4nHIUj55GOkIdy
	BtwUVqEKJP+ZffOuBhEe/KpMevykMrYgQnXdwoq8EZxA4SCJqjoXyfvgZfyOwVQfe4bE7VgCbMR
	wdpW2IVk5doxejnHgnQL6hcYlMSAke7utCvqarx85hX0u+TQW+FVIF5mmb
X-Google-Smtp-Source: AGHT+IGORNmfjN5U27fWblEFr0gG9JaRpKciF0QGPID2ssgcD9GpVhPXzuylf8UVbONt9w4fBfj50ibZd+neI/wdTfA=
X-Received: by 2002:a17:902:eccd:b0:223:23d7:ee6e with SMTP id
 d9443c01a7336-2254779cf01mr7327605ad.3.1741708339458; Tue, 11 Mar 2025
 08:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-4-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-4-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:52:06 -0700
X-Gm-Features: AQ5f1JopsCMicSlWW9WEocdxT-Ij1nex7XG1znUoz_DTuz0IqRSEIh6IJu_Ad9I
Message-ID: <CAHS8izOFAhGKxvCR0nXq0Kdvz=2A1KSJ0E_k2XJ-X8wniNH+ug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: drop rtnl_lock for queue_mgmt operations
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> All drivers that use queue API are already converted to use
> netdev instance lock. Move netdev instance lock management to
> the netlink layer and drop rtnl_lock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry. <almasrymina@google.com>

--=20
Thanks,
Mina

