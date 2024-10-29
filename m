Return-Path: <linux-kernel+bounces-387686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574999B549F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AA51F237C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BF194AD6;
	Tue, 29 Oct 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RltIjhF6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6218FDDF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235679; cv=none; b=CuJidTF8opdX/gNqmOlMS2Mil6B5yzu7blV0dEGpnaqlm8N4Did3Td/rDa8bkUEr9g6Ghsq4VlGXEyn228ImSafqYVX1BFm1v/g+h3onDVpQ9jO6b4WT02pls5vjpuudoCMw3lqoOqn/cXenrLq1Wy/W/DegzYO0XA/X6T90Cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235679; c=relaxed/simple;
	bh=S1703cyT+edCIiD/vyQbgM7U8QSHOkGBkJY7OT0F0kk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fpPl08l912KVWaTfyH+0qo0rT0f9CMHYqCIbdeoUdBTwOiiYesxcYxzAD84jzJhhnpv0lxn0UiahstpNgw/+EvUSz6k41YhZC3XYLrZdQm0eylSiBsOSg0Ecmp4QuJiuRDn23sTWHteF4uK0aej8DJoyQC6aZOHTWvnrh+eEDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RltIjhF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730235676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43e2Evie9F4dANboMZ7JeIucTF4uD+J7mlJDUVVEjDg=;
	b=RltIjhF65eCqpzw+hdSEDbpfUcDhu260ybUfAHMdf9UxHutOK6ylY7kLtdzWozM0lMjmPd
	U43rwyf+etEE1iAwImUz6c2KK4EJEvf0T9Cv5h32w9STt+hyFo7hz6jf9uHZ8tSx4I1e6B
	ytiUOzEtVtguKdZsUNfud4NUwwXNEMU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-UV9VhizINP2B3bwBe171AQ-1; Tue, 29 Oct 2024 17:01:13 -0400
X-MC-Unique: UV9VhizINP2B3bwBe171AQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a2ccb77ceso400954066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235672; x=1730840472;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43e2Evie9F4dANboMZ7JeIucTF4uD+J7mlJDUVVEjDg=;
        b=ugcWS0C3DjgMR3Vo8qhvzzZtV7q8MTnkkO36fEyeKs1TYG8/unBq4fY8m1EbXw5JEb
         HOYQ11GH7QXJptYy+fJCQwWNxs18ODZNI9OWm0jgZcUbbXF8yAVZuHmST8ZTPIBeRgz4
         jWFAV9Snmb+35zqAhWNyS1LthyX3TcIzQWRmUmQl5NgWABIIfUM/fDSc5OpKGshltjvK
         kjzb1+EFGVKc+jLkLX666kxOQ3b+TPH1pA4Hn7xG6x0PfCA3TH0I4MrxLFYZaaV5NFm2
         I3BEEe8pUuMdwnqlrAg3FdykYb+Oyjmz+cbC7/bjeTY8EgLEA0oNXfOYIkMAhuIVvzLG
         8U9A==
X-Forwarded-Encrypted: i=1; AJvYcCWTq0RnPn/KYLJBwSb8HqENIQvfcbqbmkQuk1aKCAcj5IFu0d+Yj2UP+ZUX5iGrE8rqcOVThcT+Y+qr3PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXG6iY8+Ln7OqIYG27g6yFT1C6+aQxET7vd82wjsFy9RmfaINe
	WA6wLio3yIuL2a8BlhLZeT2DxF6cnQ7TD3iFwxTTm/fdF1jfw8ueHOdDLAr8PKYKFqX80mAsyyu
	tKBDgTRNvVfrvGRByx3hqSldHBBIsLiKG7RxawJE9FJvcHVoF6xOWD9CSlF0j+g==
X-Received: by 2002:a17:907:1c29:b0:a99:e67a:d12d with SMTP id a640c23a62f3a-a9de61ce61bmr1233011366b.48.1730235672447;
        Tue, 29 Oct 2024 14:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1qigmT2ZHXS67eFLNcxyTAr/uVtukSkT86//Ve1k4KoNyQor1IgHemQv7UZizKSFDozLXDg==
X-Received: by 2002:a17:907:1c29:b0:a99:e67a:d12d with SMTP id a640c23a62f3a-a9de61ce61bmr1233008866b.48.1730235672019;
        Tue, 29 Oct 2024 14:01:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm507491966b.134.2024.10.29.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:01:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1822C164B269; Tue, 29 Oct 2024 22:01:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: syzbot <syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: Bad page state in bpf_test_run_xdp_live
In-Reply-To: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
References: <671ecfe4.050a0220.2b8c0f.01ed.GAE@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 29 Oct 2024 22:01:10 +0100
Message-ID: <8734ked3op.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -246,6 +246,7 @@ static void reset_ctx(struct xdp_page_head *head)
        head->ctx.data_meta = head->orig_ctx.data_meta;
        head->ctx.data_end = head->orig_ctx.data_end;
        xdp_update_frame_from_buff(&head->ctx, head->frame);
+       head->frame->mem = head->orig_ctx.rxq->mem;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,


