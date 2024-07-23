Return-Path: <linux-kernel+bounces-260094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3593A2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274251F2224B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E1155A24;
	Tue, 23 Jul 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyPaJmWu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE57155731
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745606; cv=none; b=O8HydWthX28y7W3YnqoqEn2eciz98pZsnOd0YIjXR2xVeeNSGzrd/6JQiw2ZzkicLYFRCCK9EMSiTrLOrQQAL4w0/QqQc4K/ooRT5KTkXJ7VYIQIEnhzx1XK36keWhCcJwIRikJdDMoEwr9MPWsG/Q5+1rroPlzZSL+ztjsWYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745606; c=relaxed/simple;
	bh=Vx994ZBr7B2D6O1BQBny1VeJblQKimuyws1bzs1/KJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7rEcbnnIn0XY7Iz1qdmnqORS+8uQImgyP1z5Rcwj1pNuWUOKf26qcT8DW7xxs0zCYadtHlKKW5uPC6F7Qwj7k1JT8jwTJre9zUP4ykyPOIpydSxhfMWSKSsod0Nurjilnh9flvC4aYFF23N7PJZiv8u2LgS/RGQnUIHH53oJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyPaJmWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNxU/3bNa0j4H+fhGmWX47X5Nrds4z8nYGKNg8PjixM=;
	b=VyPaJmWu3Db99Plh4iEauR9ikiIvIicNhKysRL9buKBPA8ZN0F2OoJjXXDXYVL5+n8QRj2
	uzlQDZrcNPcNcEEOT++w6a/w0lU4PH2IcjQa3DQY5c36fLS9T5kGU4/2dZSK9ITCMCQHmI
	Xi7VySu3s4HOETnF/Ahb4PTm00VuvYY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-v2YMVQbfNi6uOwAqB4QI2g-1; Tue, 23 Jul 2024 10:40:00 -0400
X-MC-Unique: v2YMVQbfNi6uOwAqB4QI2g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44b181a4edaso96768681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745600; x=1722350400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNxU/3bNa0j4H+fhGmWX47X5Nrds4z8nYGKNg8PjixM=;
        b=HhsGuHrkKv7v+IWw0gWTNU7M75Uzj476TiGOdwOMmQOZXSRq6SVnc++K1D0Wj+NWox
         1LYOrkYC+mBHr+LTs0deKsA1+qVCmn4hsVF0q0XQ9W7xkZruA4EJGkbd/kP8w99evMfY
         imG41TwvO44JepUAQ7Pfc7aeGYZXDvJ85RugSuuFkbPdImM0/e17LZbPPoRy2LMpVLPY
         UJHEtvmTohkAm5QbDFMbubuij9gy0Epf5+lw9BA5DX0fyckEnaWwu44N44VWaBjmcobz
         iTP5eQeNf69PplCJtjmwRpSZ0YtG1iew3TRlhb0srj0Fbm4uTni3YXIGx/OEhK7cqSXB
         8rrg==
X-Forwarded-Encrypted: i=1; AJvYcCVRZtYsF/RODvrNu2e5bwmAdy8SHcWW1QoX7QsC939b2c3QpI7RW/bTpfX74md2y5w2sv0L+7NAToRlUADTtZEoZeAiLmrzhloBLq++
X-Gm-Message-State: AOJu0YxsT4A/cOxI8qPQvi9WypAzQeOKrdfnPzMsSryJyXxCC7xqsrEp
	aXa7LDbxs/nr5fxo9J/yqzfMgdvOhHchboEvFdHPswyzaYKxT5cBMlqZns9a0y0zx46/M+w1fX7
	o36gBrLqEoZpPqMR+uNRuw+QKlgGG+08KBaMUadAGY1D9JdrN8wytXfjWLX52CQ==
X-Received: by 2002:ac8:5907:0:b0:447:e1ea:ef7 with SMTP id d75a77b69052e-44fc7f5fdd3mr32125401cf.9.1721745600389;
        Tue, 23 Jul 2024 07:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiMZj0dsaL52oy96COzOxwC33HyqPV0AzPadJvk/DwDmZBHiZG8Nq4+kUIoA7ql1zFm7LEkw==
X-Received: by 2002:ac8:5907:0:b0:447:e1ea:ef7 with SMTP id d75a77b69052e-44fc7f5fdd3mr32125021cf.9.1721745599845;
        Tue, 23 Jul 2024 07:39:59 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04062sm45383271cf.40.2024.07.23.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:39:59 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:39:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 04/14] af_vsock: generalize bind table
 functions
Message-ID: <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-5-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710212555.1617795-5-amery.hung@bytedance.com>

On Wed, Jul 10, 2024 at 09:25:45PM GMT, Amery Hung wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This commit makes the bind table management functions in vsock usable
>for different bind tables. Future work will introduce a new table for
>datagrams to avoid address collisions, and these functions will be used
>there.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
> 1 file changed, 27 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index acc15e11700c..d571be9cdbf0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>       sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>+                                                 struct list_head *bind_table)
> {
>       struct vsock_sock *vsk;
>
>-      list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>+      list_for_each_entry(vsk, bind_table, bound_table) {
>               if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>                       return sk_vsock(vsk);
>
>@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>       return NULL;
> }
>
>+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+      return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>+}
>+
> static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>                                                 struct sockaddr_vm *dst)
> {
>@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_struct *work)
>
> /**** SOCKET OPERATIONS ****/
>
>-static int __vsock_bind_connectible(struct vsock_sock *vsk,
>-                                  struct sockaddr_vm *addr)
>+static int vsock_bind_common(struct vsock_sock *vsk,
>+                           struct sockaddr_vm *addr,
>+                           struct list_head *bind_table,
>+                           size_t table_size)
> {
>       static u32 port;
>       struct sockaddr_vm new_addr;
>
>+      if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
>+                    "table size too small, may cause overflow"))
>+              return -EINVAL;
>+

I'd add this in another commit.

>       if (!port)
>               port = get_random_u32_above(LAST_RESERVED_PORT);
>
>@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct
>vsock_sock *vsk,
>
>                       new_addr.svm_port = port++;
>
>-                      if (!__vsock_find_bound_socket(&new_addr)) {
>+                      if (!vsock_find_bound_socket_common(&new_addr,
>+                                                          &bind_table[VSOCK_HASH(addr)])) {

Can we add a macro for `&bind_table[VSOCK_HASH(addr)])` ?

>                               found = true;
>                               break;
>                       }
>@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>                       return -EACCES;
>               }
>
>-              if (__vsock_find_bound_socket(&new_addr))
>+              if (vsock_find_bound_socket_common(&new_addr,
>+                                                 &bind_table[VSOCK_HASH(addr)]))
>                       return -EADDRINUSE;
>       }
>
>@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>        * by AF_UNIX.
>        */
>       __vsock_remove_bound(vsk);
>-      __vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>+      __vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
>
>       return 0;
> }
>
>+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>+                                  struct sockaddr_vm *addr)
>+{
>+      return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);

What about using ARRAY_SIZE(x) ?

BTW we are using that size just to check it, but all the arrays we use
are statically allocated, so what about a compile time check like
BUILD_BUG_ON()?

Thanks,
Stefano


>+}
>+
> static int __vsock_bind_dgram(struct vsock_sock *vsk,
>                             struct sockaddr_vm *addr)
> {
>--
>2.20.1
>


