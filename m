Return-Path: <linux-kernel+bounces-274374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B194777A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3732C281C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256001514E1;
	Mon,  5 Aug 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFcFYrmy"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D851509B3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847206; cv=none; b=T7yqA7g2J/U/30hP+aWSesDagVwBPK9QwZME/PNNoxqhmJ9DMjA82R44/ln4j9YdiQjdWELUqZfsW31u9ItpHugL2HEWrAhdL/KCpcSFjilZPwYaXodNF7YdEgC+elWXWw7Rlc8J1+MoejK5gloWBgs1ekX5t0b/Gad1VCGJwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847206; c=relaxed/simple;
	bh=+QeAcYgwZWfrituWGwqVmeQsadpHXzGektiodHZjf84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khZVki7LJHm3C8b3Zcv8+UhinvjKxs4JQjVIUxchca8htEriinxxuJMOmy9Fc8yEWBb62YCZN9pwdaE+LwKTmgqHXSRinUMHgz1hQr6qDZAr26gc0dxElC45qcAdeJRXyj9xfcXEbjdDvzmL1SCDuJ0m0L8oOH6Se+hG9SYduZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFcFYrmy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so5710a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722847203; x=1723452003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=entCZfiVHBFVDEWOeIthEZ96rKxsZnXZCzUJ55LPSZs=;
        b=nFcFYrmyqSFGntClCMY3XY0jvB4Tt/f1vGDgbxSa1S+bXPXik9gEdUcQVpWEXKn2pn
         wSWBN0hMe9jMYOjIj4gHnImpAgjDOz5yzGDZtPRGuvIQw/s3Et0eC4w9rsUw0v/P60iC
         Tigfsd6ErP+NpMKqG2GoSflq46YI9Qvj/C1vhSH4MwHBDGJdG18rB+c00eCHn+2sjQaV
         ca7Wp6wq9atkZeUzWoRlri3UhEZ25c5Jx5RyXv9d5dvU5jDIzPQDbsBTFbU31E/3v6+0
         51bhxWK1f2Tl8dxFunJoUwkkeEB12wu0EbcsoTNHcGN5/pLJUkUpr8ChChWJOkHCjs6R
         Sjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847203; x=1723452003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=entCZfiVHBFVDEWOeIthEZ96rKxsZnXZCzUJ55LPSZs=;
        b=fJCeb3RsSnNtj/kaMhrJ6EuF/ACCDcH9ae+IVJBKKQEWj5HZKusAgvXCbTy3yo8jJN
         TldNILxAVodRn5PmFgn1YXsThqTD/pxHQs3Km7Qb2WxOyeD6rgKlmnQ0XBg331665UBG
         M2G9dhJk5vf89l1nY63YygE2O88PRlnpmql3XAdk2ucy0GbXmdoMfdx2kXeP2/lI0ZF+
         Fweia9G24p2QFSmt1dOSWH8L7dUN4Z0B+pVb1GCUmq2uu3yohOX4BH2QFLJYG3f5ogwF
         OqvldOZvs+Xev5dSNWeClIvwhw7h1eHH6morAFEHx+RHQNHPNZztxzXLfJPlGoW3BXZI
         sFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX05+DoGjq2VR1dOmvfbk+i9kQrjx9DKyA7bG9+uBzXtS1y8bn+uj/0GSTNugWuvu9uEEwIyt+whCPad8/NLBV52iJogolfNkGYgAqy
X-Gm-Message-State: AOJu0YyB8OeEp2CPfnCK9R10OXpwO5oqdc/9f9Z888kzmJrEouCGT8/X
	0jMnOkiVXb2ix0fHC96nsRuwR9qqMsV4w9Zswo+jdVvbMCRC+Um62ybNbFknDzNr2tNDp9/DBRX
	SUhxB01hV0CKT0TQThunWNUvoQ2aABUnybCz0
X-Google-Smtp-Source: AGHT+IFdJr10J60UQVpdLncVN9PxgFluZr8MnNc+pMVhjD4N1bAEOas0ed5HkbYf/F1Ugm/6XTXOS9gIYlX+9dp/Zc0=
X-Received: by 2002:a05:6402:26cb:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b9caf072d4mr183817a12.7.1722847202752; Mon, 05 Aug 2024
 01:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Aug 2024 10:39:49 +0200
Message-ID: <CANn89iLaPXXNv1NC3+XyVLfX+0VVX5XQB0xobf8zAY2b95HX+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Use clamp() in htcp_alpha_update()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 8:20=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Using clamp instead of min(max()) is easier to read and it matches even
> better the comment just above it.
>
> It also reduces the size of the preprocessed files by ~ 2.5 ko.
> (see [1] for a discussion about it)
>
> $ ls -l net/ipv4/tcp_htcp*.i
>  5576024 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
>  5573550 27 juil. 10:21 net/ipv4/tcp_htcp.new.i
>
> [1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.a=
culab.com/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>

