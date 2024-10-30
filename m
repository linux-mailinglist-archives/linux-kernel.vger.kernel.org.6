Return-Path: <linux-kernel+bounces-388968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF49B66BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE1B235BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F41F4FCC;
	Wed, 30 Oct 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FwYuAiT"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8361F4295
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300403; cv=none; b=IuJpfwJmT8V2s7q0NkeSxsbmmVkzbIxUfJ0rqkb32XRyvFn0kC0eQjxiXPCQlOCs0x70g7A463AN3R6F8++F6d3PLlQagMDt8s01dDi4Sn9yMqDrqSmHJKuj9XVO59mIWWBUcHhtuevC3czXXk/uSR9mbzjJLyQlr+El4rUKcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300403; c=relaxed/simple;
	bh=uoWze0AFqGEBBuJL+IHIOIyHzv7bxNM24tB4dFyRAlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXjYsodjJ+OTXvrj8DCKTWRZW5Rz/14T67sdYNX/9wJ/PEgA/sMW3Eil+K6JHPmEoMHbLo83jfivszBZ8ncDVpIw1oXSjyA3pniumz1jm6Er3ddrFn2x0Aud5z3HYeN2Zc02W5sYfRcZvk8bw7UI6bDc0CaqsU0WTw0DvMh1W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FwYuAiT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so311271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730300400; x=1730905200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW8S8WBlORDTYGL1pb5mR6Fb+1WUMKbWZMEBW0G2lRs=;
        b=2FwYuAiTPw15hfw1ZxlQqdEXJDNuxI6K/8wgqjY7aNKve07s9scPeGHuwVhZo20SkS
         +ELZqdD/nUyott9tkJTDx6ZTAO96DwxvSwi+UkPpG4GQYOHg+k4trxYYHxc0OtVSi7ot
         g4lQcsY91jF1BnzDd/auiHX5CdDCd+MGTEA7UK9NXl2EEK3VatHzOqxMLB51TTMKxLWT
         cof1Jdf6YPoNXDVLQb7f6/h/wTxhMZwDxNUetdO2StMzvpwGMGfrmoLkIeskJMmo/i8C
         fjtXhNbLNZGzWN1Kf9OzFG0kTtVchMx36dx5rfHEreAE2j2ouB2XGgfO0Fl5oFLLYcWX
         gRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300400; x=1730905200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW8S8WBlORDTYGL1pb5mR6Fb+1WUMKbWZMEBW0G2lRs=;
        b=DwDpFOvSwSZpOHqdSimdkelT7ROfMpHRQG2OWIrwfO3GqlNGbw4aruqLDUU+FzaSaU
         Kwsl9l8EsjcmwCTZGaxIsR0holdKBwaYdRTFXktvB1oWDQcqX5fq4EzHwhl2a3Hmn04g
         egbTwpywQgc7eiqpd18b9MjR0GcCbYrjjB5DTBA038FfeFOX8A9Pg49ffyb3xUS+7C93
         baV8OZ8OkBZQRJIBmlnTcL9me4eICfoW6bEoEJ5YSRvMDquGeiEGoKo0grsqpDNK748C
         5Q3dKZA9YNzG8uaIoihOWI0HZK3ZxcVE7DfOYG6QnJSJDtfRf6uT63lPKcuJQ78/0fVH
         9jQA==
X-Forwarded-Encrypted: i=1; AJvYcCUmqPYpd/fvcvb6Wcaqn91kMDxwijYtFRtbj0YJCnVpCoCpLTJXTTcMDJkZDHn+Pz6Y23ZjWkC9rCQRvEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPD9aWs546tkMOYqDulH9VuHnzHqg2IScX9vY2uYJRihfUQ2ZT
	BQjQiW1Y70ju/2G9lOgIS67OVQ/g6M41EC5IUyce8f+mQrlnrQYKM7EKxQaIVFULbCs3qWA3dM0
	Le0u7EjZfmK+uWgC0FRNeGk9k2SAsN6JWUlt1
X-Gm-Gg: ASbGncsE1mQk+2RGZRPD+NPlkp4IGQ/x7QIRCEdzkkTpYWSI2C0PVSWMH2lBx0pHhel
	LZiYiIpMyngxYwASPVxGSYthHYP/tKWI=
X-Google-Smtp-Source: AGHT+IFwQRC1OM1gOyKoR/O/t02TCtvuvF1tbAha8ccPoXgqMdwrxYU0mf40JkfMIXKC4/9HFpcyjbWJ5vMjBZtQKT0=
X-Received: by 2002:ac8:5d91:0:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-46166dadbe0mr7711771cf.9.1730300400312; Wed, 30 Oct 2024
 08:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me>
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 30 Oct 2024 07:59:48 -0700
Message-ID: <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, 
	horms@kernel.org, willemb@google.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:27=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> The goal of the series is to simplify and make it possible to use
> ncdevmem in an automated way from the ksft python wrapper.
>
> ncdevmem is slowly mutated into a state where it uses stdout
> to print the payload and the python wrapper is added to
> make sure the arrived payload matches the expected one.
>
> v6:
> - fix compilation issue in 'Unify error handling' patch (Jakub)
>

Since I saw a compilation failures on a couple of iterations I
cherry-picked this locally and tested compilation. I'm seeing this:

sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/hw
TARGETS=3Dncdevmem 2>&1
make: Entering directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'
  CC       ncdevmem
In file included from ncdevmem.c:63:
/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../..=
/../tools/net/ynl/generated/ethtool-user.h:23:43:
warning: =E2=80=98enum ethtool_header_flags=E2=80=99 declared inside parame=
ter list
will not be visible outside of this definition or declaration
   23 | const char *ethtool_header_flags_str(enum ethtool_header_flags valu=
e);
      |                                           ^~~~~~~~~~~~~~~~~~~~
/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../..=
/../tools/net/ynl/generated/ethtool-user.h:25:41:
warning: =E2=80=98enum ethtool_module_fw_flash_status=E2=80=99 declared ins=
ide
parameter list will not be visible outside of this definition or
declaration
   25 | ethtool_module_fw_flash_status_str(enum
ethtool_module_fw_flash_status value);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../..=
/../tools/net/ynl/generated/ethtool-user.h:6766:45:
error: field =E2=80=98status=E2=80=99 has incomplete type
 6766 |         enum ethtool_module_fw_flash_status status;
      |                                             ^~~~~~
ncdevmem.c: In function =E2=80=98do_server=E2=80=99:
ncdevmem.c:517:37: error: storage size of =E2=80=98token=E2=80=99 isn=E2=80=
=99t known
  517 |                 struct dmabuf_token token;
      |                                     ^~~~~
ncdevmem.c:542:47: error: =E2=80=98SCM_DEVMEM_DMABUF=E2=80=99 undeclared (f=
irst use in
this function)
  542 |                             (cm->cmsg_type !=3D SCM_DEVMEM_DMABUF &=
&
      |                                               ^~~~~~~~~~~~~~~~~
ncdevmem.c:542:47: note: each undeclared identifier is reported only
once for each function it appears in
ncdevmem.c:543:47: error: =E2=80=98SCM_DEVMEM_LINEAR=E2=80=99 undeclared (f=
irst use in
this function)
  543 |                              cm->cmsg_type !=3D SCM_DEVMEM_LINEAR))=
 {
      |                                               ^~~~~~~~~~~~~~~~~
ncdevmem.c:557:52: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  557 |                                         dmabuf_cmsg->frag_size);
      |                                                    ^~
ncdevmem.c:562:56: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  562 |                         token.token_start =3D dmabuf_cmsg->frag_tok=
en;
      |                                                        ^~
ncdevmem.c:566:42: error: =E2=80=98SO_DEVMEM_DONTNEED=E2=80=99 undeclared (=
first use
in this function)
  566 |                                          SO_DEVMEM_DONTNEED, &token=
,
      |                                          ^~~~~~~~~~~~~~~~~~
ncdevmem.c:573:56: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  573 |                         token.token_start =3D dmabuf_cmsg->frag_tok=
en;
      |                                                        ^~
ncdevmem.c:576:54: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  576 |                         total_received +=3D dmabuf_cmsg->frag_size;
      |                                                      ^~
ncdevmem.c:579:44: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  579 |                                 dmabuf_cmsg->frag_offset >> PAGE_SH=
IFT,
      |                                            ^~
ncdevmem.c:580:44: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  580 |                                 dmabuf_cmsg->frag_offset %
getpagesize(),
      |                                            ^~
ncdevmem.c:581:44: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  581 |                                 dmabuf_cmsg->frag_offset,
      |                                            ^~
ncdevmem.c:582:44: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  582 |                                 dmabuf_cmsg->frag_size,
dmabuf_cmsg->frag_token,
      |                                            ^~
ncdevmem.c:582:68: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  582 |                                 dmabuf_cmsg->frag_size,
dmabuf_cmsg->frag_token,
      |                                                                    =
^~
ncdevmem.c:583:60: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  583 |                                 total_received, dmabuf_cmsg->dmabuf=
_id);
      |                                                            ^~
ncdevmem.c:585:40: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  585 |                         if (dmabuf_cmsg->dmabuf_id !=3D dmabuf_id)
      |                                        ^~
ncdevmem.c:589:40: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  589 |                         if (dmabuf_cmsg->frag_size % getpagesize())
      |                                        ^~
ncdevmem.c:595:65: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  595 |
dmabuf_cmsg->frag_offset,
      |                                                                 ^~
ncdevmem.c:596:65: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  596 |
dmabuf_cmsg->frag_size);
      |                                                                 ^~
ncdevmem.c:601:60: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  601 |
dmabuf_cmsg->frag_offset,
      |                                                            ^~
ncdevmem.c:602:52: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  602 |                                         dmabuf_cmsg->frag_size);
      |                                                    ^~
ncdevmem.c:604:73: error: invalid use of undefined type =E2=80=98struct dma=
buf_cmsg=E2=80=99
  604 |                                 print_nonzero_bytes(tmp_mem,
dmabuf_cmsg->frag_size);
      |
         ^~
make: *** [../../../lib.mk:222:
/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drive=
rs/net/hw/ncdevmem]
Error 1
make: Leaving directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'

The errors are still there even without the CFLAGS=3D"-static". Can you
take a look before merge?

