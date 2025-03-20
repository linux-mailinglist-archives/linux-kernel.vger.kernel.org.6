Return-Path: <linux-kernel+bounces-569703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F3A6A654
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CCE173089
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D641F94D;
	Thu, 20 Mar 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPaOo1Zs"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7171367
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474224; cv=none; b=a9IavcE35HvmtH0qQ7xO2qw5XElmrQNeMVoocxzm4Yi1IhjtK+Lmi/he05dlZOwY2RO4nYRMozdVIIqYa6uU0yP6AozfIvOi4Ce9/+QF+bYF83rvFKh0YsH6+UggX9ntr1AUlxe6HnOWPDWMyJMQKkhc2fBetRPgSvh+W91J1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474224; c=relaxed/simple;
	bh=qe76n7w8WG2/vcG8sw7IiSgCXf7eBBkZ60h0gIOTUNU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DwhoglciUYFpmYSO37xwKQAZf97VXmrGoA4QY7xz2ZE4x/sIed2mFWrb36M4EsgTBPpZ7npUZ+sbdMB5JfJ5NTknP7CX77krUZ61CHO4PO8JY1VA8Sy4Z66m8xkbVh5Np1mhaIMFtwgKiTJo/BrBgQEBVsIzp6SclYbU9nxHUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPaOo1Zs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742474219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw6wMIYMJ1AHQenbcEv56UwG8Bnbs4a/rZ4UNrxeeV8=;
	b=MPaOo1ZsDBnhct6Qww0pUpr15rn8LiP3QJx1nKQ0zU/QdWuhVM8+FVRdqYV67YBjZBSTeV
	o2wW4MDvUBkgTVF5B1tFIwjobCU/PXmWM5wV2or+Qio27JfXbbZLA6HM0AbJy7NWVyrORv
	nI4ICnNjWxD7HmEplggQ4hDYzOQW29I=
Date: Thu, 20 Mar 2025 12:36:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b403d53317c0bd8125cecbc0651e54338ca11bfd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 2/3] bpf, sockmap: avoid using sk_socket
 after free when reading
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mhal@rbox.co, sgarzare@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
In-Reply-To: <Z9tiqkSOH9vuOOJL@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-3-jiayuan.chen@linux.dev>
 <Z9tiqkSOH9vuOOJL@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

March 20, 2025 at 08:34, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Mon, Mar 17, 2025 at 05:22:55PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> There are potential concurrency issues, as shown below.
> >=20
>=20>  '''
> >=20
>=20>  CPU0 CPU1
> >=20
>=20>  sk_psock_verdict_data_ready:
> >=20
>=20>  socket *sock =3D sk->sk_socket
> >=20
>=20>  if (!sock) return
> >=20
>=20>  close(fd):
> >=20
>=20>  ...
> >=20
>=20>  ops->release()
> >=20
>=20>  if (!sock->ops) return
> >=20
>=20>  sock->ops =3D NULL
> >=20
>=20>  rcu_call(sock)
> >=20
>=20>  free(sock)
> >=20
>=20>  READ_ONCE(sock->ops)
> >=20
>=20>  ^
> >=20
>=20>  use 'sock' after free
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  RCU is not applicable to Unix sockets read path, because the Unix =
socket
> >=20
>=20>  implementation itself assumes it's always in process context and h=
eavily
> >=20
>=20>  uses mutex_lock, so, we can't call read_skb within rcu lock.
> >=20
>=20
> Hm, I guess the RCU work in sk_psock_drop() does not work for Unix
>=20
>=20domain sockets either?
>=20
>=20Thanks.
>

Although the Unix domain socket framework does not use RCU locks, the
entire sockmap process protects access to psock via RCU:
'''
rcu_read_lock();
psock =3D sk_psock(sk_other);
if (psock) {
 ...
}
rcu_read_unlock(); // `sk_psock_drop` will not execute until the unlock
'''

Therefore, I believe there are no issues with the psock operations here.

Thanks~

