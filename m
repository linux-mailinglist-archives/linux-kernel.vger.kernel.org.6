Return-Path: <linux-kernel+bounces-403452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50649C35EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B96AB217CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6892624B28;
	Mon, 11 Nov 2024 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMirI1iU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38A8F5A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288644; cv=none; b=jhqc8wP2A/FGUYA/rKqpwccwWNjp9QG8FpQH61ff6xz0av4otoOuAbG4V/DCo0jJoZkGot0e2iToWlZz0NrExcrSqdsp7hH9g1kvPOxVphtUEOgYTZcnUEOU+Pppb85EziNCsx1SxaVxzx1KS772F77oRR8NfloQWpZgNKZRdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288644; c=relaxed/simple;
	bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZLV7jizd9dQZoQawcavJnzrLlsRLQvGEH5pna735xD+h+y8ijuHebqF4x+yoG7kjh7oS5GBSHYQGr6q0ejRHx85yFwY6SyzW+NlksK22SdpciQcwO7lGCQyoncVySG4knPmjI5euzxMQU2ylHidMW3zTFBiWL7MkwDdDdSIUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMirI1iU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
	b=UMirI1iUq0bEwjOXCS1iRYYaGkm/TlX73RjZHmFhZ/LXEL771N++0tzt0e3SDEwRlcqyNR
	pJGeVkAPwDWxdzsOTABgFtAEfMkgRl2pqGX/e4ch9MFXYYG4UfD+VjndR643pdKKgmkViO
	h0dT1IcVGf8jE9tKmzLGVC54GPZWm8E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-1c1DQkKjOXOSo5EsfK37ZA-1; Sun, 10 Nov 2024 20:30:41 -0500
X-MC-Unique: 1c1DQkKjOXOSo5EsfK37ZA-1
X-Mimecast-MFC-AGG-ID: 1c1DQkKjOXOSo5EsfK37ZA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21159b15562so57070625ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288640; x=1731893440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
        b=lsfXQeM9rfLhodc2bIQz7eTkAarlGxxRow+uVKrpF1yyQeCqZ4DqIY2/kEm18kNxpM
         9zM6fQ2xNKdlXwPQhoKe+wSDlC/YcczQUb/nS8+rol16WIm6ViIa5e7NR8Nb3oQQ6b+X
         RFUNh3ok6q31BWVUKkeiFAsDyzrmTBxIm11Fqa/RqvJaRPAQPTTBX8RWYI+1AqqIAVYs
         koRbO/drvK6ItUVbdj5WO0PK422SeZNslCn4ucK5KzoWgkub1PCbXadAA5VjETrT/G1c
         Kt2LUAvTEpPJ2QvcjSCLw/6lW59+GThXE0f/YAbzjv8qtTtFjtgKVlUISZWGl2qfkSUA
         yIwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgq70hViLcGz1ujFJvWZ8IQYD/RMgwMv/3z40zukXGszbDOXO64bplL3LRS7wzqFOHrUUct8uHN0xIER4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2NBoyXWjnU/SwE23yMQJgeRwML9OLFjwKZkeB4QrJQCu+6h0
	pIu26yVbq1rlIy3KCToS5/EayS5hnKnXDBwLVAdfa+ZRZVqT3Pu1J5N9v2v5l3HhUbpS95puM2v
	0rPQ3eGX+7gtE2jJMOhHyKYo3YfnS/m/doD5dTJ6bybxwD31kRFRLL1GIBKhXU9Hy9wD9SF8MnX
	zYAXPQN6o9FKUfoHPNXRHae8nzmKHvcYqmyxko
X-Received: by 2002:a17:902:cec7:b0:20b:b7b2:b6c5 with SMTP id d9443c01a7336-211835cd1a9mr142109805ad.54.1731288640285;
        Sun, 10 Nov 2024 17:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZRBnvWh5GWrgUU3+bWrELT9eUGDwENrtwgxF8fs2ll6MrUvLLBsrBK0BTbf9dHmzIUgOcdwoSUpYFkpBBW3M=
X-Received: by 2002:a17:902:cec7:b0:20b:b7b2:b6c5 with SMTP id
 d9443c01a7336-211835cd1a9mr142109475ad.54.1731288639882; Sun, 10 Nov 2024
 17:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104085706.13872-1-lulie@linux.alibaba.com> <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:30:28 +0800
Message-ID: <CACGkMEundAnfw9mHY64xTGtrwB6TcZkfmVQc3K2L7vBy6SWSnA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue number
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, mst@redhat.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Hi Jason, could you review this firstly?
>
> Thanks.
>

It looks like the series has been merged.

Anyhow it looks good to me.

Thanks


