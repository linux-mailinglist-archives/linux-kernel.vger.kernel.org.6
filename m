Return-Path: <linux-kernel+bounces-349690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412598FA11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C81F285139
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7261CF28D;
	Thu,  3 Oct 2024 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUrYGu3M"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B31AB52C;
	Thu,  3 Oct 2024 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995803; cv=none; b=anCHdGu25Is62qm5LsU1mBzwJEjkgVDw1ETgFaaQ+pUjyi2vyLQNTGwlG9H9gdJ1l3eN53734SboibvPr2x4odYQ6WnRtVFJkGjs5M6eWdPVB8sf9aJSzR5D0K5hd81sIVL/8c/4G1Glcg1q7X9fxkz8im7QCgLe3jXHZioFaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995803; c=relaxed/simple;
	bh=KTAhubmF+XdYalroJyT4CW7w74UfrFqL7BD0IJFjemI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diiDtP0RBgBqOSyosUMmeHZO0KvQRsJKENaeWSfgeQAmGb93RVjuxWSJ/XzIRGSUVDkr9hl+YiDTvkL8WPvtO8tLmR1MW6HFSEZP1OQm7HV9XLk1CV3OK6JmJGsPrn1dXY2ylHQWR5Mtxv7MtBnvxK3xKVm+B/Uq8lf7Xa7UXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUrYGu3M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-717839f9eb6so216124b3a.3;
        Thu, 03 Oct 2024 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727995801; x=1728600601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTAhubmF+XdYalroJyT4CW7w74UfrFqL7BD0IJFjemI=;
        b=bUrYGu3MtOtXBTxBsntfrKfP8zXQQDckHlKTz4CFYU7uur5g48UX4olhPNxMRc7hEF
         3RnDciowOvk1SyUps46EaPjVLziCkXmgpG1rE+0JyzAmtmzZY2wFO1mBc4mrU7JC+yhz
         sG63qOw6+fklroVdlnnvMM78sE8IhDCzd9ztfXzsgQ6Hd7HtHJ0sWngmqNYEsLRnTzVL
         wG43wak0k/YkXfQhZIaTQ2w34hOhlPFdQtqJXqc7qrp7icS1yDMqDwvUE5wM/aN2Ccko
         bjr3M/if3PaVQZZogZUgSJbK3egQogtWn/nlKd6wPIuRE4JjFi/Y4LMFct1AbmS0WK3P
         7JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995801; x=1728600601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTAhubmF+XdYalroJyT4CW7w74UfrFqL7BD0IJFjemI=;
        b=X++waYZQlNXuJZPF8DPNEnsoNj+YI3LgbjKljfsimuUEizIkJEWDZgBNLzc+y9d7aO
         zcHjaBu0LPfUe0ov/PSKZAATGIdr3rGWUsCmyjbRkj0woWKPRleb6qBy6uPme51DC9m1
         951ZvWqc0UKg7WfLOM8Wp3abwmJh4klvm+UrBIhqfoq9qPttgo/OqSkUs4skdUc9zvie
         nbIo1jtJ9hYRr1pGejHNTZy/96JUF+fAgbZ5dJbh6SVULEZ8ZvXyHdtONeY7zuHZwK2b
         UtBY3AEbJGSn1JgUiOhqKC4hy/gR3zWwCThHqy4F16NJvg+whQw7p8BUPtsCdTnk8OHg
         py9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYAm/ivvtMTOIJ1Oj07v3T2cdrjvLLvr8QyrXSnzO0OLQ5a9YmDKnc0I3lhfqIpAdmynnFCociaRVymTE5BNU=@vger.kernel.org, AJvYcCWaG5SF8uP8jLy1mFeHanRBdTeZrapUkWEIstI1u2FuOVff7s/Iheo+iS5nbItZYXEzxZsgs683PdK1KJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7E9mVLWKVdjQOjjB3m3lKDOceXuKj/p4TRngn2lbJo1AqxvB
	dM56M/7fLnkIJ1LhXzJoh/OX/ekqLkA5pc3BsrXA+XgHSHjG3JXei3FzaXyDvLmF8aqirkic8xD
	CEY7NeK40aEWOxhpRhuups9w7MhU=
X-Google-Smtp-Source: AGHT+IGEnMEaMRwHJsgJjl9DJrCplq6rSG+i/uvTMJrsp8tHpy4xemqXsOMgZvfXeCPS8ha8JVUl4QKYIr7RCPFaYPQ=
X-Received: by 2002:a05:6a00:464e:b0:70b:705f:8c5d with SMTP id
 d2e1a72fcca58-71de2446c96mr403436b3a.4.1727995801451; Thu, 03 Oct 2024
 15:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-26-dakr@kernel.org>
 <20240928204357.3a28dada.gary@garyguo.net> <CANiq72nuZ41eDXkybGBbGRMgJzUOe1rRZioS-amJfH7UV-9cMQ@mail.gmail.com>
 <fd889e4a-3da7-4ade-a0a4-c4fb1feb540f@kernel.org>
In-Reply-To: <fd889e4a-3da7-4ade-a0a4-c4fb1feb540f@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Oct 2024 00:49:48 +0200
Message-ID: <CANiq72=9Y2eauk3LbJnnmM7N-iiN0ET-XwJ=uMJsWLyfWysQ4w@mail.gmail.com>
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:54=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> So, I guess you'll just fix it up when applying the series?

Sure, if there is no need for a new version, then no worries.

Cheers,
Miguel

