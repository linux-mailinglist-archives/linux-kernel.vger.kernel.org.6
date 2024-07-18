Return-Path: <linux-kernel+bounces-256250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A1934B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0301C228EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5F12C474;
	Thu, 18 Jul 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivKEW6PR"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2153A267
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296836; cv=none; b=lz59SAPjC2UZowFO8x5UE9Gp109jBSYE0LgUUwjS52rYadgMtQaPr/4qGt6eK/XMxNfcdmZNkezZ+2HfG82x6j/SH/rJfumi21xJYqKzTLS+HIwPGq8PCa3N6NJFfZ6OxUx8572fPmeFVtqby1SUPQf8meFzyFwTVyoW4A3ChSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296836; c=relaxed/simple;
	bh=ZmAYGqQv8W5oBh9B4LEUgj5NaAO8IPRYm4hSxk6bRqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJ/I+D9k5VpqhpQycsgy5+iy5BiX9zESwf/zXfPTK0rEkxqOoHgA08YHSF4c0m++rAFWD186RHt6gD6UL0FMpiFGaB/3hAq6UYxALUCvnfErBsOJlGtmTh9CHlAHhdUFfMyt1m+cLa/x7fD/rOuhc3pxTwGaoSeZ5jxwyniBxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivKEW6PR; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8101b144fddso255197241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721296833; x=1721901633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8rxLnL1/ZBBcqIXYNDAEdacIhoiDUKyiW14lHy/sPY=;
        b=ivKEW6PRtw+0ftxjbZHwVEcmG9ngOXxpzuGoeQM/VhXk2uK77YlayppqQ7CzZqxTXn
         FCnrhTPZHoIY8Ezzl0MAB5O8aGeV/TR9dUaJ3TTin38uTXHj/3RBT1GcXcYfmuEX8CUN
         UUo5MKx4O/xblH/lgfjSSUDZ/GKkVGtDuaPUWo1L9tzqZja6mAhuSAuNdnrU8ax4+cao
         yiglj0rA/15h2DPkqq06wFpBJXYNLh8nAOM+49QSkzeIc25U3pS5RWQ3tjXFL+b66uri
         8L1pfvO4Lnk/BDTaJib6kvc6wud7Kjs78lV0XERYQSdMs0E7HXIIuBZ6D4SZXT78Ohoo
         4vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296833; x=1721901633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8rxLnL1/ZBBcqIXYNDAEdacIhoiDUKyiW14lHy/sPY=;
        b=f8asTIm+1/i03O2adrkmGj8TzPJfsCXGDTBqGOuwa/VCuUP598/Pmu87F3f0f9sWlS
         Ve4ZZKZ/wfk2mJo+dSh0NUpGolqoWBRIkFgLI+eXXjgZvuFxjZVEzFktLZKjqP1jC9Nl
         roCLBWQwyxt1eZG/LAaXalspUos4r36FPWgGY4yedpGCevvTUwXMdrP0fVse0N0IiRSg
         LrU5TFtWGOIIpe6vprBuTgcRc64WE2WnY4t9YyTjGwrP2Lep355YfyX1w+Y5PaJfbvXC
         sFgA3sZVee2QRiDhozHIa/Utkp3TdHww8ya4v68H19E+51n24PqopfxExW7TwaQ3K2NF
         w6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVLvUXal2PkF4InbwisjZnZPuGO3+hCGM7Y8nsolr3sLCPjSLPbDNi2tQSATU6TZ05JpAZQ0f/ZL5Jp0XVsfhym4x2LKROM8GXkr2v8
X-Gm-Message-State: AOJu0YzbBQkwZDcCip1vpqT0fJAjPsrnUVcaJ5rI/XsYmaUnAJSm7iaB
	bysXyVDmepGXzv5Qmn+AiKArrzsRbJYZbEt4ZKj1U0Vl11EeRPVxWytMxL0zv6O9ZlY4WMdqanG
	ltISMGHKCef2oAIKzbYbUZGiqCrNjfnWsgIkl9g==
X-Google-Smtp-Source: AGHT+IFIvveE9+hwc5fI8Gm5gVQl0mC2NeEDpF93k0AHQdtX5YlfWQmHyGpNH53iq8RyOj9bqhAuN02rDxmieuEzWT4=
X-Received: by 2002:a05:6102:2c8d:b0:48f:e683:7b46 with SMTP id
 ada2fe7eead31-4915976d01fmr5598002137.3.1721296833133; Thu, 18 Jul 2024
 03:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com>
 <umwai5fxohuz6apprv6ouhdrnomal4a7cmyhmzpf6dnamnvti2@un4hxx52hkge>
 <bdf39b00-b889-42d2-ba07-4e2881fe9105@quicinc.com> <fsoczpwh4za37yavm5wau7n2ie2eemu4aux5xh3jubjfshlceu@4h7nfmi2qe2t>
In-Reply-To: <fsoczpwh4za37yavm5wau7n2ie2eemu4aux5xh3jubjfshlceu@4h7nfmi2qe2t>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 18 Jul 2024 15:30:21 +0530
Message-ID: <CAFA6WYPveNBhghBJGgxYFSj+WyQysXh8a_8VmhyqFqTeEhkmKg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Implement Qualcomm TEE IPC and ioctl calls
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 17 Jul 2024 at 18:01, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Adding TEE mailing list and maintainers to the CC list.

Thanks. I am not going to reiterate what Jens said in the other thread
but going to cover some additional points.

>
> Amirreza, please include them in future even if you are not going to use
> the framework.
>
>
> On Wed, Jul 10, 2024 at 09:16:48AM GMT, Amirreza Zarrabi wrote:
> >
> >
> > On 7/3/2024 9:36 PM, Dmitry Baryshkov wrote:
> > > On Tue, Jul 02, 2024 at 10:57:35PM GMT, Amirreza Zarrabi wrote:
> > >> Qualcomm TEE hosts Trusted Applications (TAs) and services that run =
in
> > >> the secure world. Access to these resources is provided using MinkIP=
C.
> > >> MinkIPC is a capability-based synchronous message passing facility. =
It
> > >> allows code executing in one domain to invoke objects running in oth=
er
> > >> domains. When a process holds a reference to an object that lives in
> > >> another domain, that object reference is a capability. Capabilities
> > >> allow us to separate implementation of policies from implementation =
of
> > >> the transport.
> > >>
> > >> As part of the upstreaming of the object invoke driver (called SMC-I=
nvoke
> > >> driver), we need to provide a reasonable kernel API and UAPI. The cl=
ear
> > >> option is to use TEE subsystem and write a back-end driver, however =
the
> > >> TEE subsystem doesn't fit with the design of Qualcomm TEE.
> > >>
> >
> > To answer your "general comment", maybe a bit of background :).
> >
> > Traditionally, policy enforcement is based on access-control models,
> > either (1) access-control list or (2) capability [0]. A capability is a=
n
> > opaque ("non-forge-able") object reference that grants the holder the
> > right to perform certain operations on the object (e.g. Read, Write,
> > Execute, or Grant). Capabilities are preferred mechanism for representi=
ng
> > a policy, due to their fine-grained representation of access right, inl=
ine
> > with
> >   (P1) the principle of least privilege [1], and
> >   (P2) the ability to avoid the confused deputy problem [2].
> >
> > [0] Jack B. Dennis and Earl C. Van Horn. 1966. Programming Semantics fo=
r
> > Multiprogrammed Computations. Commun. ACM 9 (1966), 143=E2=80=93155.
> >
> > [1] Jerome H. Saltzer and Michael D. Schroeder. 1975. The Protection of
> > Information in Computer Systems. Proc. IEEE 63 (1975), 1278=E2=80=93130=
8.
> >
> > [2] Norm Hardy. 1988. The Confused Deputy (or Why Capabilities Might Ha=
ve
> > Been Invented). ACM Operating Systems Review 22, 4 (1988), 36=E2=80=933=
8.
> >
> > For MinkIPC, an object represents a TEE or TA service. The reference to
> > the object is the "handle" that is returned from TEE (let's call it
> > TEE-Handle). The supported operations are "service invocation" (similar
> > to Execute), and "sharing access to a service" (similar to Grant).
> > Anyone with access to the TEE-Handle can invoke the service or pass the
> > TEE-Handle to someone else to access the same service.
> >
> > The responsibility of the MinkIPC framework is to hide the TEE-Handle,
> > so that the client can not forge it, and allow the owner of the handle
> > to transfer it to other clients as it wishes. Using a file descriptor
> > table we can achieve that. We wrap the TEE-Handle as a FD and let the
> > client invoke FD (e.g. using IOCTL), or transfer the FD (e.g. using
> > UNIX socket).
> >
> > As a side note, for the sake of completeness, capabilities are fundamen=
tally
> > a "discretionary mechanism", as the holder of the object reference has =
the
> > ability to share it with others. A secure system requires "mandatory
> > enforcement" (i.e. ability to revoke authority and ability to control
> > the authority propagation). This is out of scope for the MinkIPC.
> > MinkIPC is only interested in P1 and P2 (mention above).
> >
> >
> > >> Does TEE subsystem fit requirements of a capability based system?

Just to make things clear, first you should have involved TEE
subsystem maintainers to discuss QTEE requirements and see how we can
evolve the TEE subsystem rather than complaining about the opposite.
What happens if another proprietary TEE implementation comes up to
reuse this capability based system as you have described for QTEE? The
reason we have a generic TEE subsystem is to allow common
functionality to be reused within the kernel to interface with
different TEE implementations.

> > >> -----------------------------------------------------------------
> > >> In TEE subsystem, to invoke a function:
> > >>    - client should open a device file "/dev/teeX",
> > >>    - create a session with a TA, and
> > >>    - invoke the functions in that session.
> > >>
> > >> 1. The privilege to invoke a function is determined by a session. If=
 a
> > >>    client has a session, it cannot share it with other clients. Even=
 if
> > >> it does, it is not fine-grained enough, i.e. either all accessible
> > >> functions/resources in a session or none. Assume a scenario when a c=
lient
> > >> wants to grant a permission to invoke just a function that it has th=
e rights,
> > >> to another client.
> > >>
> > >> The "all or nothing" for sharing sessions is not in line with our
> > >> capability system: "if you own a capability, you should be able to g=
rant
> > >> or share it".
> > >
> > > Can you please be more specific here? What kind of sharing is expecte=
d
> > > on the user side of it?
> >
> > In MinkIPC, after authenticating a client credential, a TA (or TEE) may
> > return multiple TEE-Handles, each representing a service that the clien=
t
> > has privilege to access. The client should be able to "individually"
> > reference each TEE-Handle, e.g. to invoke and share it (as per capabili=
ty-
> > based system requirements).
> >
> > If we use TEE subsystem, which has a session based design, all TEE-Hand=
les
> > are meaningful with respect to the session in which they are allocated,
> > hence the use of "__u32 session" in "struct tee_ioctl_invoke_arg".
> >
> > Here, we have a contradiction with MinkIPC. We may ignore the session
> > and say "even though a TEE-Handle is allocated in a session but it is a=
lso
> > valid outside a session", i.e. the session-id in TEE uapi becomes redun=
dant
> > (a case of divergence from definition).
> >

First of all, we need an open source reference user-space
implementation to better understand how these capabilities are going
to be used in real world use-cases. Is there any enforcement done from
the kernel side or it's purely a user-space concept?

> > >
> > >> 2. In TEE subsystem, resources are managed in a context. Every time =
a
> > >>    client opens "/dev/teeX", a new context is created to keep track =
of
> > >> the allocated resources, including opened sessions and remote object=
s. Any
> > >> effort for sharing resources between two independent clients require=
s
> > >> involvement of context manager, i.e. the back-end driver. This requi=
res
> > >> implementing some form of policy in the back-end driver.
> > >
> > > What kind of resource sharing?
> >
> > TEE subsystem "rightfully" allocates a context each time a client opens
> > a device file. This context pass around to the backend driver to identi=
fy
> > independent clients that opened the device file.
> >
> > The context is used by backend driver to keep track of the resources. T=
ype
> > of resources are TEE driver dependent. As an example of resource in TEE
> > subsystem, you can look into 'shm' register and unregister (specially,
> > see comment in function 'shm_alloc_helper').
> >
> > For MinkIPC, all clients are treated the same and the TEE-Handles are
> > representative of the resources, accessible "globally" if a client has =
the
> > capability for them. In kernel, clients access an object if they have
> > access to "qcom_tee_object", in userspace, clients access an object if
> > they have the FD wrapper for the TEE-Handle.
> >
> > If we use context, instead of the file descriptor table, any form of ob=
ject
> > transfer requires involvement of the backend driver. If we use the file
> > descriptor table, contexts are becoming useless for MinkIPC (i.e.
> > 'ctx->data' will "always" be null).

From purely user-space perspective, the TEE context is really a file
descriptor only corresponding to "/dev/teeX". It really depends on the
TEE backend driver if they want to tie up some TEE context or not.

> >
> > >
> > >> 3. The TEE subsystem supports two type of memory sharing:
> > >>    - per-device memory pools, and
> > >>    - user defined memory references.
> > >> User defined memory references are private to the application and ca=
nnot
> > >> be shared. Memory allocated from per-device "shared" pools are acces=
sible
> > >> using a file descriptor. It can be mapped by any process if it has
> > >> access to it. This means, we cannot provide the resource isolation
> > >> between two clients. Assume a scenario when a client wants to alloca=
te a
> > >> memory (which is shared with TEE) from an "isolated" pool and share =
it
> > >> with another client, without the right to access the contents of mem=
ory.
> > >
> > > This doesn't explain, why would it want to share such memory with
> > > another client.
> >
> > Ok, I believe there is a misunderstanding here. I did not try to justif=
y
> > specific usecase. We want to separate the memory allocation from the
> > framework. This way, how the memory is obtained, e.g. it is allocated
> > (1) from an isolated pool, (2) a shared pool, (3) a secure heap,
> > (4) a system dma-heap, (5) process address space, or (6) other memory
> > with "different constraints", becomes independent.
> >
> > We introduced "memory object" type. User implements a kernel service
> > using "qcom_tee_object" to represent the memory object. We have an
> > implementation of memory objects based on dma-buf.
> >

I would really like to see use-cases for integration of dma-buf with
TEE subsystem. You can see earlier attempt here [1] but without an
upstream implementation of secure heap we can't land it upstream.

[1] https://lkml.org/lkml/2022/8/12/544

> > >
> > >> 4. The kernel API provided by TEE subsystem does not support a kerne=
l
> > >>    supplicant. Adding support requires an execution context (e.g. a
> > >> kernel thread) due to the TEE subsystem design. tee_driver_ops suppo=
rts
> > >> only "send" and "receive" callbacks and to deliver a request, someon=
e
> > >> should wait on "receive".
> > >
> > > There is nothing wrong here, but maybe I'm misunderstanding something=
.
> >
> > I agree. But, I am trying to re-emphasize how useful TEE subsystem is
> > for MinkIPC. For kernel services, we solely rely on the backend driver.
> > For instance, to expose RPMB service we will use "qcom_tee_object".
> > So there is nothing provided by the framework to simplify the service
> > development.
> >

OP-TEE has a similar requirement to access RPMB as a kernel supplicant
service [1]. Like I said above there is nothing stopping us to extend
TEE subsystem with common parts like RPMB kernel service to be reused
among backend drivers.

[2] https://lore.kernel.org/lkml/20240527121340.3931987-1-jens.wiklander@li=
naro.org/T/

> > >
> > >> We need a callback to "dispatch" or "handle" a request in the contex=
t of
> > >> the client thread. It should redirect a request to a kernel service =
or
> > >> a user supplicant. In TEE subsystem such requirement should be imple=
mented
> > >> in TEE back-end driver, independent from the TEE subsystem.
> > >>
> > >> 5. The UAPI provided by TEE subsystem is similar to the GPTEE Client
> > >>    interface. This interface is not suitable for a capability system=
.

Have a look at how Trusted Services TEE implementation [3] (non GPTEE
compliant) works nicely with TEE subsystem.

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/tee/ts-tee.rst

> > >> For instance, there is no session in a capability system which means
> > >> either its should not be used, or we should overload its definition.
> > >
> > > General comment: maybe adding more detailed explanation of how the
> > > capabilities are aquired and how they can be used might make sense.
> > >
> > > BTW. It might be my imperfect English, but each time I see the word
> > > 'capability' I'm thinking that some is capable of doing something. I
> > > find it hard to use 'capability' for the reference to another object.
> > >
> >
> > Explained at the top :).
> >
> > >>
> > >> Can we use TEE subsystem?
> > >> -------------------------
> > >> There are workarounds for some of the issues above. The question is =
if we
> > >> should define our own UAPI or try to use a hack-y way of fitting int=
o
> > >> the TEE subsystem. I am using word hack-y, as most of the workaround
> > >> involves:
> > >>
> > >> - "diverging from the definition". For instance, ignoring the sessio=
n
> > >>   open and close ioctl calls or use file descriptors for all remote
> > >> resources (as, fd is the closet to capability) which undermines the
> > >> isolation provided by the contexts,
> > >>
> > >> - "overloading the variables". For instance, passing object ID as fi=
le
> > >>   descriptors in a place of session ID, or
> > >>
> > >> - "bypass TEE subsystem". For instance, extensively rely on meta
> > >>   parameters or push everything (e.g. kernel services) to the back-e=
nd
> > >> driver, which means leaving almost all TEE subsystem unused.
> > >>
> > >> We cannot take the full benefits of TEE subsystem and may need to
> > >> implement most of the requirements in the back-end driver. Also, as
> > >> discussed above, the UAPI is not suitable for capability-based use c=
ases.
> > >> We proposed a new set of ioctl calls for SMC-Invoke driver.
> > >>

Please work constructively to evolve TEE subsystem. There is no
specific definition here for TEE subsystem but rather it provides a
generic user-space interface for clients to interact with underlying
TEE implementation.

> > >> In this series we posted three patches. We implemented a transport
> > >> driver that provides qcom_tee_object. Any object on secure side is
> > >> represented with an instance of qcom_tee_object and any struct expos=
ed
> > >> to TEE should embed an instance of qcom_tee_object. Any, support for=
 new
> > >> services, e.g. memory object, RPMB, userspace clients or supplicants=
 are
> > >> implemented independently from the driver.

Why do we want to implement a separate platform driver for each of
them when a single DT node is sufficient to tell presence of QTEE? It
looks like an improper use of DT nodes.

> > >>
> > >> We have a simple memory object and a user driver that uses
> > >> qcom_tee_object.
> > >
> > > Could you please point out any user for the uAPI? I'd like to underst=
and
> > > how does it from from the userspace point of view.
> >
> > Sure :), I'll write up a test patch and send it in next series.
> >
> > Summary.
> >
> > TEE framework provides some nice facilities, including:
> >   - uapi and ioctl interface,
> >   - marshaling parameters and context management,
> >   - memory mapping and sharing, and
> >   - TEE bus and TA drivers.
> >
> > For, MinkIPC, we will not use any of them. The only usable piece, is ua=
pi
> > interface which is not suitable for MinkIPC, as discussed above.

Don't you want to support kernel clients to access QTEE services? I
already see an example related to UEFI runtime variables access [4] as
there wasn't a QTEE driver upstream to support that.

[4] drivers/firmware/qcom/qcom_qseecom_uefisecapp.c

-Sumit

> >
> > >
> > >>
> > >> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> > >> ---
> > >> Amirreza Zarrabi (3):
> > >>       firmware: qcom: implement object invoke support
> > >>       firmware: qcom: implement memory object support for TEE
> > >>       firmware: qcom: implement ioctl for TEE object invocation
> > >>
> > >>  drivers/firmware/qcom/Kconfig                      |   36 +
> > >>  drivers/firmware/qcom/Makefile                     |    2 +
> > >>  drivers/firmware/qcom/qcom_object_invoke/Makefile  |   12 +
> > >>  drivers/firmware/qcom/qcom_object_invoke/async.c   |  142 +++
> > >>  drivers/firmware/qcom/qcom_object_invoke/core.c    | 1139 +++++++++=
+++++++++
> > >>  drivers/firmware/qcom/qcom_object_invoke/core.h    |  186 +++
> > >>  .../qcom/qcom_object_invoke/qcom_scm_invoke.c      |   22 +
> > >>  .../firmware/qcom/qcom_object_invoke/release_wq.c  |   90 ++
> > >>  .../qcom/qcom_object_invoke/xts/mem_object.c       |  406 +++++++
> > >>  .../qcom_object_invoke/xts/object_invoke_uapi.c    | 1231 +++++++++=
+++++++++++
> > >>  include/linux/firmware/qcom/qcom_object_invoke.h   |  233 ++++
> > >>  include/uapi/misc/qcom_tee.h                       |  117 ++
> > >>  12 files changed, 3616 insertions(+)
> > >> ---
> > >> base-commit: 74564adfd3521d9e322cfc345fdc132df80f3c79
> > >> change-id: 20240702-qcom-tee-object-and-ioctls-6f52fde03485
> > >>
> > >> Best regards,
> > >> --
> > >> Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> > >>
> > >
>
> --
> With best wishes
> Dmitry

