Return-Path: <linux-kernel+bounces-245481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C092B320
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF4282BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886515539D;
	Tue,  9 Jul 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJpo7gRb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC0154C15
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515825; cv=none; b=GQAfSUaSPRP3UQcNqmfTRTS5mvZuX6vm5+ZPuMHmqXdxsQz3C4JqEgoL7LujsIRq6dLPzGQ/cwtijUhN5yjA61u5fpWSadT5qupUvMe0KVceUbeDuE1+3YwL/SMgx3rsh0HTNpzFEXYa3+uCIa4Y38ufSPVd/NQeH2U+OKaiUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515825; c=relaxed/simple;
	bh=RwybyzzL0dNpt2i8Hun7VUiB0fNyNCWjuNNKxXa+kdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l13Z/1rbrHlPnI1vU/dp2yQlAJe0CAx1DLhO6hJ+n39ZWX1vJHsGhC4Xym4Q9q4Us/HxDW3voXouaZQLQ5kVENFrRbzB079oQIjvTkgHQ6y8fTO7oB5gt/s/Vh8WWfuztSkOV4wfdVzysx7Y94xOpZeAH2vaDEBFbw8ykIYOdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJpo7gRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720515822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wGrefDyHXPEmhLFp1M8+y8s3v1m1eiH05AfmCPOG95I=;
	b=BJpo7gRbVm8pScrif0qLvHPPn0eP98UUrZLMLONV3oI5cCfzglO/XsEdOk8F0FiDlEuAId
	K2ZKnh0Ri74EC/FSZjwvOYWA0Vx/MMQuVHicCWVDMfrQu4Kw6RgQokQa/zKtOU1cPq/Oms
	a6LDVT26K6DDxMM3tS8zmA/sSlw97/c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-4DuzHk-zM1y6NVgcZ0djbQ-1; Tue, 09 Jul 2024 05:03:40 -0400
X-MC-Unique: 4DuzHk-zM1y6NVgcZ0djbQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee9cf9398aso5160021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720515819; x=1721120619;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGrefDyHXPEmhLFp1M8+y8s3v1m1eiH05AfmCPOG95I=;
        b=R5SqGceexB2tdm2FMT40u3pZS1GO76TBH57Q3mVwvhGkLyZMO5eYJbuU1MJ6VaXFGa
         XAudZj25IGGh3PFqtrSeG8b8hrDZshzynzDx31KeRBBUlNT/Mti4AEBSYfnt2jp1JOG9
         ZsREjzP3Ft4jXVqWTzCSeSD/jcstAWiVwRl77tpOsr5QxEjA4WU39riczAIH0e5Pr6xV
         BuFc92BB1Oe0xj7ekVsLvmoITL4rakfEJnkAHJDzF17FVsaA0xICZzdgNOmJg/5clqjM
         QAUerLU8nxbozhQXW8RkNbjPOyPyg/OyaCBZc8HWimDOUyL1W328RNdC1npPcrdHeRCM
         ib9w==
X-Forwarded-Encrypted: i=1; AJvYcCUwqzAc8UAo9M9QkQNTSAJnK4OYG+PJyfZalnFho5cklw5FsLychKE7Sv23/4jBpaBkVAtbv9N5Nhl3tsFfinByTy8AbfaQq1niKbDJ
X-Gm-Message-State: AOJu0Yywy/QJVBOhnfA1g43xYrmSUcw/w8vSD47kRASPnHWDHZI3P/bj
	V07gMnBXAd4ULi8oNNrPGzoOOnGyJ3765mUmKg343JfCn1qTxjzdQA9Pt/oFpatfEJQWYZq+w5Q
	BahMjMedMU4tdoEH4tQuMTnWYeQHBOUp/g6eNEqD/ZETDrssAJ8ZsCzfq1tIxnA==
X-Received: by 2002:a05:6512:3f09:b0:52c:def2:d8af with SMTP id 2adb3069b0e04-52eb99da573mr1153955e87.4.1720515818858;
        Tue, 09 Jul 2024 02:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqXEA3xrkSPy78VcJY90d8zrk5a2k8vyWg3ZIb3jTeTIJNBT9NRLD+6W0UWQiWEDFvdSSQug==
X-Received: by 2002:a05:6512:3f09:b0:52c:def2:d8af with SMTP id 2adb3069b0e04-52eb99da573mr1153932e87.4.1720515818365;
        Tue, 09 Jul 2024 02:03:38 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab6d3sm1912544f8f.112.2024.07.09.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:03:37 -0700 (PDT)
Message-ID: <ce5973fe2017177e6f4c1f577fa8309fe7258612.camel@redhat.com>
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up
 tunnels
From: Paolo Abeni <pabeni@redhat.com>
To: James Chapman <jchapman@katalix.com>, Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com, 
	syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com, 
	syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Date: Tue, 09 Jul 2024 11:03:36 +0200
In-Reply-To: <a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>
References: <20240708115940.892-1-hdanton@sina.com>
	 <a65127e4-544b-27e6-a1e1-e20e5fb4d480@katalix.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 14:57 +0100, James Chapman wrote:
> On 08/07/2024 12:59, Hillf Danton wrote:
> > On Mon, 8 Jul 2024 11:06:25 +0100 James Chapman <jchapman@katalix.com>
> > > On 05/07/2024 11:32, Hillf Danton wrote:
> > > > On Thu,  4 Jul 2024 16:25:08 +0100 James Chapman <jchapman@katalix.=
com>
> > > > > --- a/net/l2tp/l2tp_core.c
> > > > > +++ b/net/l2tp/l2tp_core.c
> > > > > @@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l2=
tp_session *session)
> > > > >    static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
> > > > >    {
> > > > >    	struct l2tp_session *session;
> > > > > -	struct list_head *pos;
> > > > > -	struct list_head *tmp;
> > > > >   =20
> > > > >    	spin_lock_bh(&tunnel->list_lock);
> > > > >    	tunnel->acpt_newsess =3D false;
> > > > > -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
> > > > > -		session =3D list_entry(pos, struct l2tp_session, list);
> > > > > +	for (;;) {
> > > > > +		session =3D list_first_entry_or_null(&tunnel->session_list,
> > > > > +						   struct l2tp_session, list);
> > > > > +		if (!session)
> > > > > +			break;
> > > > > +		l2tp_session_inc_refcount(session);
> > > > >    		list_del_init(&session->list);
> > > > >    		spin_unlock_bh(&tunnel->list_lock);
> > > > >    		l2tp_session_delete(session);
> > > > >    		spin_lock_bh(&tunnel->list_lock);
> > > > > +		l2tp_session_dec_refcount(session);
> > > >=20
> > > > Bumping refcount up makes it safe for the current cpu to go thru ra=
ce
> > > > after releasing lock, and if it wins the race, dropping refcount ma=
kes
> > > > the peer head on uaf.
> > >=20
> > > Thanks for reviewing this. Can you elaborate on what you mean by "mak=
es
> > > the peer head on uaf", please?
> > >=20
> > Given race, there are winner and loser. If the current cpu wins the rac=
e,
> > the loser hits uaf once winner drops refcount.
>=20
> I think the session's dead flag would protect against threads racing in=
=20
> l2tp_session_delete to delete the same session.
> Any thread with a pointer to a session should hold a reference on it to=
=20
> prevent the session going away while it is accessed. Am I missing a=20
> codepath where that's not the case?

AFAICS this patch is safe, as the session refcount can't be 0 at
l2tp_session_inc_refcount() time and will drop to 0 after
l2tp_session_dec_refcount() only if no other entity/thread is owning
any reference to the session.

@James: the patch has a formal issue, you should avoid any empty line
in the tag area, specifically between the 'Fixes' and SoB tags.

I'll exceptionally fix this while applying the patch, but please run
checkpatch before your next submission.

Also somewhat related, I think there is still a race condition in
l2tp_tunnel_get_session():

	rcu_read_lock_bh();
        hlist_for_each_entry_rcu(session, session_list, hlist)
                if (session->session_id =3D=3D session_id) {
                        l2tp_session_inc_refcount(session);

I think that at l2tp_session_inc_refcount(), the session refcount could
be 0 due to a concurrent tunnel cleanup. l2tp_session_inc_refcount()
should likely be refcount_inc_not_zero() and the caller should check
the return value.

In any case the latter is a separate issue.

Thanks,

Paolo


