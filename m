Return-Path: <linux-kernel+bounces-232901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7991AFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E4286C46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207681CFB9;
	Thu, 27 Jun 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rue1XiAg"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984F200DE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516602; cv=none; b=oLoW3aBWKDaDy+hwM/xdusu7Ik/fFD++VHBJXsX0mjLzeZw9+UMf3gGaRfPDbqIOUSRhpmckR/bDTjIAXAdvAAWo/U2a5dBYR0XPEJ9uJyMWUcdcQEGcgx1IRhp63qjd99ylrtuZPykm080phd+CspvPvXxg7zDu8KewgkyvsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516602; c=relaxed/simple;
	bh=iBOh0atC42lqPdrLoVvDYoOS2XF1EIzrwaPW36hsAh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6kcS34DU+Xi5oEgij0qCcvJgwrWO8VEXF6hvDXCNv5AChvr53BEHoLFQkgzzUVxyiwcJVd5UtNHJTF3EcDMpfKKk/p7sTncigDKpV1i649IILkDVm6IpwIUMp7Ox1nly74Uy7CfLRVn3dd2k7HsuWaLzPNltO8j/4jmSRC0KH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rue1XiAg; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e034b3e95adso658145276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719516600; x=1720121400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdz+RrVgteZReZT9YJg/zM1QvaWDeqeNdyJjVUh7iT0=;
        b=Rue1XiAg4ijxWwvKeEg3FpLdHGCKAVV/vkyCNohvDTowHsjjOQ1dVDaL4sk8WP3519
         FekKY8gcpf+IYjXzYlfC5gvOyA1yBCbRuAWAkQ72qY8ECG1ELttEJCqCSBVdOhSFtaMV
         SfgFqZZKfYHP/Pv+LMv3GLp9qPB304cGh0oRlyHAiZBImZDGFp2zsLD7rRdpIjGfZGb0
         ulJRofZmytvWGaSxeuXQu2rqzZMqKzgSqIY3SC6FelvqKQZV7SRe8hWLjP9LKHmvTqkL
         m3CpeqxYpU2Sxkh+kZCrnCXcRJ64hLmWegFGQ4eZrR7on97MCFBPirKzto1hFtnccQ4O
         oGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516600; x=1720121400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdz+RrVgteZReZT9YJg/zM1QvaWDeqeNdyJjVUh7iT0=;
        b=b0icd4tdfj5p5KWB6iizyU/18eDm3GFQ7KtcNqH5oFZr7JjAZD3YNp4vu7ZC7hRclp
         OSYMAfiQ2FcWPPkTsUhq44rfMWLVurKV0D9E+Lnmq8uzWTbO/WSKtcjGEuT5xRNBICGo
         PJ0UylrR/qjMBYl5vP9GQkychngkkcbus7nDnpWMR2iQBfPZ0Gk/FDVTsIutYl0CbU6Y
         /c3F4gncUr9Fst2Uwv88lznSK/32A5HaBYFReepeK2Yy/oyuwWifj1Skrn31ge1N8JJ+
         zPpZ1bkKNR1/0Ls0SzJ+2N83MTD3VQimgMLUBzsXSR0Bisy+O1Ln3JATBbQLvwVbU4Km
         /6zg==
X-Forwarded-Encrypted: i=1; AJvYcCXH9TYRjaHOn2lvkaXP+8c2Prbi1PpwfuSjvhdOvZtmWlX0kvRMobKbLYPureTNVCOfb+dU9oXs0lWh39sHNtfr2GjnwaQqiozlzOJz
X-Gm-Message-State: AOJu0YwRNt4bxaGJddsC9c0fZ2gqMVuqwKLbr9s4t3E6Iy6m9biXjFzj
	PEg8awVdLM+NWQ38Ns26myuNdldUPtt4oIQ8wLEWP0O6eGByBR/sYH5I/kb2KWsp7TPn5uLduPO
	8WazrjtXD4/7DfS7IqywtzqUcvFW19tY7oHgr
X-Google-Smtp-Source: AGHT+IG5zda6W6h+VyTY+2oP03mzZadPKl6xTjtfOgSRdYt4ZmyFwUOr8h9KN8Rs/nKDGLnHUnBSp9tBCGT9XIo5Y0E=
X-Received: by 2002:a05:6902:525:b0:dfd:a095:f98c with SMTP id
 3f1490d57ef6-e031bea726amr7464296276.21.1719516599651; Thu, 27 Jun 2024
 12:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <202406271019.BF8123A5@keescook>
In-Reply-To: <202406271019.BF8123A5@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Jun 2024 15:29:48 -0400
Message-ID: <CAHC9VhRFP5m9k5JhQr-8QXJ=8JL_OCzDWxcO8dGxuLnk5X6qJA@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> diff --git a/security/security.c b/security/security.c
> index 9c3fb2f60e2a..a8658ebcaf0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1613,7 +1613,8 @@ static void inode_free_by_rcu(struct rcu_head *head=
)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -       call_void_hook(inode_free_security, inode);
> +       struct rcu_head *inode_blob =3D inode->i_security;
> +
>         /*
>          * The inode may still be referenced in a path walk and
>          * a call to security_inode_permission() can be made
> @@ -1623,9 +1624,11 @@ void security_inode_free(struct inode *inode)
>          * leave the current inode->i_security pointer intact.
>          * The inode will be freed after the RCU grace period too.
>          */
> -       if (inode->i_security)
> -               call_rcu((struct rcu_head *)inode->i_security,
> -                        inode_free_by_rcu);
> +       if (inode_blob) {
> +               call_void_hook(inode_free_security, inode);
> +               inode->i_security =3D NULL;
> +               call_rcu(inode_blob, inode_free_by_rcu);

See my response to Micka=C3=ABl, unless we can get some guidance from the
VFS folks on the possibility of calling security_inode_free() once
when the inode has already been marked for death and is no longer in
use, I'd rather see us split the LSM implementation into two hooks,
something like this pseudo code (very hand-wavy around the rcu_head
inode container bits):

void inode_free_rcu(rhead)
{
  inode =3D multiple_container_of_magic(rhead);
  /* LSMs can finally free any internal state */
  call_void_hook(inode_free_rcu, inode)
  inode->i_security =3D NULL;
}

void security_inode_free(inode)
{
  /* LSMs can mark their state as "dead", but perm checks may still happen =
*/
  call_void_hook(inode_free, inode);
  if (inode->i_security)
    call_rcu(inode, inode_free_rcu);
}

> +       }
>  }

--
paul-moore.com

