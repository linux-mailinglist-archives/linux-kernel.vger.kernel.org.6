Return-Path: <linux-kernel+bounces-389308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E49B6B34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2600B226E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDE213141;
	Wed, 30 Oct 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9vuLcsq"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FC1F706A;
	Wed, 30 Oct 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310129; cv=none; b=D03rIYo5x/eRPg1rfaqiAjEd8myEAswFzXoNmiRp8bKoN1HI3RAcWF9UQxR4T2Z3xNIhMHHaH3Xr4PF6ijPXF3ohgOTUakMvq22cZX6lNJ+8ILJ5C9f7o6q6piDTq1/fs3+3UmMyl0bqNQBO1LF4DVx4PLOVjPuW320/QZaSLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310129; c=relaxed/simple;
	bh=hDs6CFSZCTUN4JetpBSFApFrfQ6+DLXmjKufaGPexVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVhVArAlrJasshgYLUcUXfDnhpkP16tWgUYq5YUtm6CBfMB7QHfrLbBLnsZQOS6XZ3YMLhI7jHabiIF1B+n8AWTCogN2u/dqDd0aUQlASGdbI34T8HFBRCaXHv62xQAQ6nkhYZ1KLa85tTPfiA0Hh5670Pglod6WnweDwdLnvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9vuLcsq; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc0992560so107107eaf.0;
        Wed, 30 Oct 2024 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730310123; x=1730914923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f7HInsfyPFKHXgppWA/PBP/MpcBpTBauQm9VyG+ZrE=;
        b=U9vuLcsqqZBHYRXHNVORDbKeIPQbg1HRM0xU4HkVn8LcRkxEP0NVMNHNl37bUu0iCf
         4mXzaQfUSjXEXtPL1hqwX4v1DJLxccx0zgdu31pqetZp2BEKDf6mLGboAk/KHJVJcgI/
         ckgAD1FTbXaiFnHLslsmTyj4MBEG0QlRUfAE94jSI8/qb7aD0tcKfoGcRefGto2x0uI/
         zg1E1FATUguvuDyJRzpHyPEyfanTewSO6auA77LScl6hi5461AmSOR0+zeg3axK0Hppd
         GDDJ8HkQgU/X0R7XZQdDpUnjV0sew0tkqsl0cN82wq6cK1DUqY4OGLzwmmqhYcK6uYw3
         ZkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310123; x=1730914923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f7HInsfyPFKHXgppWA/PBP/MpcBpTBauQm9VyG+ZrE=;
        b=F3boLeAmHTkRr/Q9sV4NrPZ4G0zPg6X/b1mhhhdlmbQEFE/EenjuNc9RRNwUp0N8bE
         v5h3/ewfYrYALOCr38keG1h4YUaXaAZlD9y5F+h0vVq2pd2HbVpMlyyPwryvNZGSB6gT
         O7Stq265vMNlMN132MBw2Zlh+2oCGUvwkfG2E+sjLlv/1PcwyHuh2mSImvXz2jTsXqmA
         3bqj+ddsTRXH4nNCNt0guGGuefhtOXVHjS8/zck35AMJerj2eg8g2VZfWFioNbFfrLHb
         P5q2qhOmpuzUELNPah1BbvdIC2FZetJcM/GxtOWQwse4Ypo2GHNpr6bGm4OMXrwFHDvz
         yBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUPlGwzGpWtSz/68b593TVyE9MBu5hVv+2icCWASP2ssL0ZAsejVI9ndYYoJCD1ISDvkdxyg5AoQpMWBQzD@vger.kernel.org, AJvYcCW+qZZxCeaRJgxNIRloON7QtcU1sJY/sAZr9Mo8bgmw6Il3tQ6qm3AixAwJb8SdZjcJB9DKRkWhGyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLvtjxn4nxhiBuUEhEzWXYO/8lOJnBstOKnuMFd3hZLdaQg0U
	z08s/bskGymTgq9rEW7vf6JlqugZ+MDCPXHOomItDrcSO5apf57qHvsRH0Slsib6SyDwFpZd1lJ
	1UJ36olBdDYrGlz7aki2WNxC4WmQ=
X-Google-Smtp-Source: AGHT+IHGfNwDP6uWyTcpbdbyY2oKR0i85g4bqK+9xU9tHsvpuZz8rE1styiXLGyXdeMMQOcw6EYTXpdAaM8AKyC300E=
X-Received: by 2002:a05:6820:554:b0:5eb:75c2:5987 with SMTP id
 006d021491bc7-5ec23909e9bmr10801101eaf.4.1730310122745; Wed, 30 Oct 2024
 10:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019195534.79603-1-yesanishhere@gmail.com>
 <20241019195534.79603-2-yesanishhere@gmail.com> <ZxsSvbXXiwNAHCWX@archie.me>
 <CABCoZhB62CKhCnZTCgTAhEh27td4Gw6XjJ-uYQJRqJuN9NPqmw@mail.gmail.com> <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com>
In-Reply-To: <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 30 Oct 2024 12:41:51 -0500
Message-ID: <CABb+yY1FPjZuw9MFZeVwoN6KFPLoH8wWzPW3S6VBWf0v5m1NNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
To: anish kumar <yesanishhere@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anish,
  It is the third ping within 10 days, please avoid. Documentation is
not a high priority, esp when it is mostly copying info from header
files.
I haven't looked closely and you haven't mentioned in the log what new
info are you adding or clearer?
From a quick look it seems just api explanation copied into doc
format. Will look closer later.

Thanks

On Tue, Oct 29, 2024 at 1:06=E2=80=AFPM anish kumar <yesanishhere@gmail.com=
> wrote:
>
> Hello Jassi,
>
> Gentle reminder for the review.
>
> On Fri, Oct 25, 2024 at 12:24=E2=80=AFPM anish kumar <yesanishhere@gmail.=
com> wrote:
> >
> > Hello Jassi,
> >
> > I hope to get some more comments from you before
> > spinning up a new revision.
> >
> > On Thu, Oct 24, 2024 at 8:38=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
> > >
> > > On Sat, Oct 19, 2024 at 12:55:34PM -0700, anish kumar wrote:
> > > > 1. added client documentation
> > > > 2. added controller documentation.
> > > > 3. added framework documentation
> > >
> > > One doc topic on each patch, please.
> > >
> > > >
> > > > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > > > ---
> > > >  Documentation/driver-api/mailbox/client.rst   | 192 ++++++++++++++=
++++
> > > >  Documentation/driver-api/mailbox/core.rst     | 182 ++++++++++++++=
+++
> > > >  Documentation/driver-api/mailbox/index.rst    |  45 ++++
> > > >  .../writing_mailbox_controller_drivers.rst    | 179 ++++++++++++++=
++
> > > >  4 files changed, 598 insertions(+)
> > > >  create mode 100644 Documentation/driver-api/mailbox/client.rst
> > > >  create mode 100644 Documentation/driver-api/mailbox/core.rst
> > > >  create mode 100644 Documentation/driver-api/mailbox/index.rst
> > > >  create mode 100644 Documentation/driver-api/mailbox/writing_mailbo=
x_controller_drivers.rst
> > > >
> > > > diff --git a/Documentation/driver-api/mailbox/client.rst b/Document=
ation/driver-api/mailbox/client.rst
> > > > new file mode 100644
> > > > index 000000000000..9088f8373423
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/mailbox/client.rst
> > > > @@ -0,0 +1,192 @@
> > > > +Mailbox Client Documentation
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Overview
> > > > +--------
> > > > +The mailbox client driver is responsible for sending and receiving=
 messages
> > > > +to and from a remote processor. It uses mailbox APIs provided by t=
he
> > > > +mailbox framework.
> > > > +
> > > > +Mailbox Structure
> > > > +-----------------
> > > > +The mailbox structure is defined as follows:
> > > > +
> > > > +.. code-block:: c
> > > > +
> > > > +   struct mbox_client {
> > > > +       //device associated with the mailbox
> > > > +       struct device *dev;
> > > > +       // callback for transmission completion
> > > > +       void (*tx_done)(struct mbox_client *client);
> > > > +       // callback to prepare for sending a message
> > > > +       void (*tx_prepare)(struct mbox_client *client);
> > > > +       // callback for received messages
> > > > +       void (*rx_callback)(struct mbox_client *client, void *data)=
;
> > > > +       // flag to indicate if transmission should block
> > > > +       bool tx_block;
> > > > +       // indicates if the client knows when transmission is done
> > > > +       bool knows_txdone;
> > > > +   };
> > > > +
> > > > +Key Functions
> > > > +-------------
> > > > +1. Requesting a Mailbox Channel
> > > > +   - **Function**: `mbox_request_channel(struct mbox_client *clien=
t,
> > > > +     unsigned int channel)`
> > > > +   - **Description**: Requests a mailbox channel for sending messa=
ges.
> > > > +   - **Parameters**:
> > > > +     - `client`: Pointer to the mailbox client structure.
> > > > +     - `channel`: The specific mailbox channel to request.
> > > > +   - **Returns**: A pointer to the mailbox channel on success, or =
an error
> > > > +     code on failure.
> > > > +
> > > > +2. Sending a Message
> > > > +   - **Function**: `mbox_send_message(struct mbox_chan *chan, void=
 *msg)`
> > > > +   - **Description**: Sends a message through the mailbox channel.
> > > > +   - **Parameters**:
> > > > +     - `chan`: The mailbox channel used for communication.
> > > > +     - `msg`: Pointer to the message to be sent (usually NULL for =
dummy
> > > > +       messages).
> > > > +   - **Returns**: 0 on success, or a negative error code on failur=
e.
> > > > +
> > > > +3. Transmitting Completion
> > > > +   - **Function**: `mbox_client_txdone(struct mbox_chan *chan, uns=
igned int
> > > > +     msg_id)`
> > > > +   - **Description**: Notifies the mailbox framework that message
> > > > +     transmission is complete.
> > > > +   - **Parameters**:
> > > > +     - `chan`: The mailbox channel associated with the message.
> > > > +     - `msg_id`: The identifier of the message that was transmitte=
d.
> > >
> > > These functions should've been documented as kernel-doc comments, tho=
ugh.
> > >
> > > > +
> > > > +Usage Example
> > > > +-------------
> > > > +In a typical mailbox client driver, the following steps are typica=
lly
> > > > +performed:
> > > > +
> > > > +1. Initialize the Mailbox Client:
> > > > +
> > > > +   .. code-block:: c
> > > > +
> > > > +      struct mbox_client my_mbox_client =3D {
> > > > +          .dev =3D &my_device,
> > > > +          .tx_done =3D my_tx_done_callback,
> > > > +          .rx_callback =3D my_rx_callback,
> > > > +          .tx_block =3D false,
> > > > +          .knows_txdone =3D true,
> > > > +      };
> > > > +
> > > > +2. Request a Mailbox Channel:
> > > > +
> > > > +   .. code-block:: c
> > > > +
> > > > +      mbox_chan =3D mbox_request_channel(&my_mbox_client, 0);
> > > > +      if (IS_ERR(mbox_chan)) {
> > > > +          // Handle error
> > > > +      }
> > > > +
> > > > +3. Send a Message:
> > > > +
> > > > +   .. code-block:: c
> > > > +
> > > > +      int ret =3D mbox_send_message(mbox_chan, NULL); // Sending a=
 dummy message
> > > > +      if (ret < 0) {
> > > > +          // Handle error
> > > > +      }
> > > > +
> > > > +4. Complete Transmission:
> > > > +
> > > > +   .. code-block:: c
> > > > +
> > > > +      mbox_client_txdone(mbox_chan, 0);
> > > > +
> > > > +Interrupt Handling
> > > > +------------------
> > > > +The mailbox interface can trigger interrupts upon message receipt.=
 Handlers
> > > > +should be implemented in the `rx_callback` function defined in the=
 mailbox
> > > > +client structure to process incoming messages.
> > > > +
> > > > +Example Mailbox Client Driver
> > > > +-----------------------------
> > > > +.. code-block:: c
> > > > +
> > > > +   struct demo_client {
> > > > +       struct mbox_client cl;
> > > > +       struct mbox_chan *mbox;
> > > > +       struct completion c;
> > > > +       bool async;
> > > > +       /* ... */
> > > > +   };
> > > > +
> > > > +   /*
> > > > +   * This is the handler for data received from remote. The behavi=
our is purely
> > > > +   * dependent upon the protocol. This is just an example.
> > > > +   */
> > > > +   static void message_from_remote(struct mbox_client *cl, void *m=
ssg)
> > > > +   {
> > > > +       struct demo_client *dc =3D container_of(cl, struct demo_cli=
ent, cl);
> > > > +       if (dc->async) {
> > > > +           if (is_an_ack(mssg)) {
> > > > +               /* An ACK to our last sample sent */
> > > > +               return; /* Or do something else here */
> > > > +           } else { /* A new message from remote */
> > > > +               queue_req(mssg);
> > > > +           }
> > > > +       } else {
> > > > +           /* Remote f/w sends only ACK packets on this channel */
> > > > +           return;
> > > > +       }
> > > > +   }
> > > > +
> > > > +   static void sample_sent(struct mbox_client *cl, void *mssg, int=
 r)
> > > > +   {
> > > > +       struct demo_client *dc =3D container_of(cl, struct demo_cli=
ent, cl);
> > > > +       complete(&dc->c);
> > > > +   }
> > > > +
> > > > +   static void client_demo(struct platform_device *pdev)
> > > > +   {
> > > > +       struct demo_client *dc_sync, *dc_async;
> > > > +       /* The controller already knows async_pkt and sync_pkt */
> > > > +       struct async_pkt ap;
> > > > +       struct sync_pkt sp;
> > > > +
> > > > +       dc_sync =3D kzalloc(sizeof(*dc_sync), GFP_KERNEL);
> > > > +       dc_async =3D kzalloc(sizeof(*dc_async), GFP_KERNEL);
> > > > +
> > > > +       /* Populate non-blocking mode client */
> > > > +       dc_async->cl.dev =3D &pdev->dev;
> > > > +       dc_async->cl.rx_callback =3D message_from_remote;
> > > > +       dc_async->cl.tx_done =3D sample_sent;
> > > > +       dc_async->cl.tx_block =3D false;
> > > > +       dc_async->cl.tx_tout =3D 0; /* doesn't matter here */
> > > > +       dc_async->cl.knows_txdone =3D false; /* depending upon prot=
ocol */
> > > > +       dc_async->async =3D true;
> > > > +       init_completion(&dc_async->c);
> > > > +
> > > > +       /* Populate blocking mode client */
> > > > +       dc_sync->cl.dev =3D &pdev->dev;
> > > > +       dc_sync->cl.rx_callback =3D message_from_remote;
> > > > +       dc_sync->cl.tx_done =3D NULL; /* operate in blocking mode *=
/
> > > > +       dc_sync->cl.tx_block =3D true;
> > > > +       dc_sync->cl.tx_tout =3D 500; /* by half a second */
> > > > +       dc_sync->cl.knows_txdone =3D false; /* depending upon proto=
col */
> > > > +       dc_sync->async =3D false;
> > > > +
> > > > +       /* ASync mailbox is listed second in 'mboxes' property */
> > > > +       dc_async->mbox =3D mbox_request_channel(&dc_async->cl, 1);
> > > > +       /* Populate data packet */
> > > > +       /* ap.xxx =3D 123; etc */
> > > > +       /* Send async message to remote */
> > > > +       mbox_send_message(dc_async->mbox, &ap);
> > > > +
> > > > +       /* Sync mailbox is listed first in 'mboxes' property */
> > > > +       dc_sync->mbox =3D mbox_request_channel(&dc_sync->cl, 0);
> > > > +       /* Populate data packet */
> > > > +       /* sp.abc =3D 123; etc */
> > > > +       /* Send message to remote in blocking mode */
> > > > +       mbox_send_message(dc_sync->mbox, &sp);
> > > > +       /* At this point 'sp' has been sent */
> > > > +
> > > > +       /* Now wait for async chan to be done */
> > > > +       wait_for_completion(&dc_async->c);
> > > > +   }
> > > > diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentat=
ion/driver-api/mailbox/core.rst
> > > > new file mode 100644
> > > > index 000000000000..d1220086da67
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/mailbox/core.rst
> > > > @@ -0,0 +1,182 @@
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +mailbox documentation
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Hardware Introduction
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Mailbox hardware is a specialized component found in multi-core
> > > > +processors and embedded systems that facilitates inter-processor
> > > > +communication (IPC) or communication between different hardware
> > > > +components. It provides a structured mechanism for sending and
> > > > +receiving messages, allowing various processors or devices to
> > > > +exchange data efficiently. Here's an overview of its key
> > > > +characteristics and functions:
> > > > +
> > > > +Key Characteristics of Mailbox Hardware
> > > > +Interrupt Handling: Many mailbox implementations support
> > > > +interrupt-driven communication. This allows a receiving processor
> > > > +to be alerted when a new message arrives, facilitating immediate
> > > > +processing without polling the mailbox constantly.
> > > > +
> > > > +Hardware Registers: Mailbox hardware often includes registers for
> > > > +configuration and status monitoring. These registers can be used
> > > > +to control the mailbox's behavior, check for available messages,
> > > > +or acknowledge message receipt.
> > > > +
> > > > +Support for Multiple Protocols: Mailboxes can support various
> > > > +communication protocols, enabling interoperability between differe=
nt
> > > > +hardware components and simplifying the integration of diverse sys=
tems.
> > > > +
> > > > +Synchronous and Asynchronous Modes: Mailbox hardware can operate i=
n
> > > > +both synchronous and asynchronous modes. In synchronous mode, the
> > > > +sender may wait for the receiver to acknowledge receipt before
> > > > +proceeding, while in asynchronous mode, the sender can continue
> > > > +executing other tasks immediately after sending the message.
> > > > +
> > > > +
> > > > +Mailbox framework design
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > +
> > > > +The mailbox facilitates interprocessor communication by allowing p=
rocessors to
> > > > +exchange messages or signals. The mailbox framework consists of:
> > > > +
> > > > +Mailbox Controller: This is platform-specific and is responsible f=
or configuring
> > > > +and managing interrupts from the remote processor. It offers a gen=
eric API for
> > > > +the mailbox client.
> > > > +
> > > > +Mailbox Client: This component handles the sending and receiving o=
f messages.
> > > > +
> > > > +
> > > > +..................................................................=
..........
> > > > +:  client driver      client_a            client_b                =
         :
> > > > +..................................................................=
..........
> > > > +                            ^-------------------^
> > > > +                                    |
> > > > +                                    |
> > > > +..................................................................=
..........
> > > > +:  controller framework          mailbox                          =
         :
> > > > +....................................|.............................=
..........
> > > > +                                    |
> > > > +                                    |
> > > > +..................................................................=
..........
> > > > +:  controller driver          device specific                     =
         :
> > > > +....................................|.............................=
..........
> > > > +                                    |
> > > > +                                    |
> > > > +kernel                              |
> > > > +..................................................................=
..........
> > > > +hardware                            |
> > > > +                                    |
> > > > +                                    |
> > > > +..................................................................=
..........
> > > > +:                             remote processor                    =
         :
> > > > +..................................................................=
..........
> > >
> > > htmldocs build errors out:
> > >
> > > Documentation/driver-api/mailbox/core.rst:57: WARNING: Block quote en=
ds without a blank line; unexpected unindent.
> > > Documentation/driver-api/mailbox/core.rst:57: CRITICAL: Missing match=
ing underline for section title overline.
> > >
> > > .....................................................................=
.......
> > > :  controller framework          mailbox                             =
      :
> > > ....................................|................................=
.......
> > >
> > > reST markup error:
> > > Documentation/driver-api/mailbox/core.rst:57: (SEVERE/4) Missing matc=
hing underline for section title overline.
> > >
> > > .....................................................................=
.......
> > > :  controller framework          mailbox                             =
      :
> > > ....................................|................................=
.......
> > >
> > > I have to fix up the design diagram and wrap it:
> > >
> > > ---- >8 ----
> > > diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentatio=
n/driver-api/mailbox/core.rst
> > > index d1220086da679f..8d56d81007c11c 100644
> > > --- a/Documentation/driver-api/mailbox/core.rst
> > > +++ b/Documentation/driver-api/mailbox/core.rst
> > > @@ -47,31 +47,32 @@ the mailbox client.
> > >
> > >  Mailbox Client: This component handles the sending and receiving of =
messages.
> > >
> > > +::
> > >
> > > -....................................................................=
........
> > > -:  client driver      client_a            client_b                  =
       :
> > > -....................................................................=
........
> > > -                            ^-------------------^
> > > -                                    |
> > > -                                    |
> > > -....................................................................=
........
> > > -:  controller framework          mailbox                            =
       :
> > > -....................................|...............................=
........
> > > -                                    |
> > > -                                    |
> > > -....................................................................=
........
> > > -:  controller driver          device specific                       =
       :
> > > -....................................|...............................=
........
> > > -                                    |
> > > -                                    |
> > > -kernel                              |
> > > -....................................................................=
........
> > > -hardware                            |
> > > -                                    |
> > > -                                    |
> > > -....................................................................=
........
> > > -:                             remote processor                      =
       :
> > > -....................................................................=
........
> > > +  +-----------------------------------------------------------------=
----------+
> > > +  |  client driver      client_a            client_b                =
          |
> > > +  +-----------------------------------------------------------------=
----------+
> > > +                              ^-------------------^
> > > +                                      |
> > > +                                      |
> > > +  +-----------------------------------------------------------------=
---------+
> > > +  |  controller framework          mailbox                          =
         |
> > > +  +-----------------------------------|-----------------------------=
---------+
> > > +                                      |
> > > +                                      |
> > > +  +-----------------------------------------------------------------=
---------+
> > > +  |  controller driver          device specific                     =
         |
> > > +  +-----------------------------------|-----------------------------=
---------+
> > > +                                      |
> > > +                                      |
> > > +  kernel                              |
> > > +  ------------------------------------------------------------------=
----------
> > > +  hardware                            |
> > > +                                      |
> > > +                                      |
> > > +  +-----------------------------------------------------------------=
---------+
> > > +  |                             remote processor                    =
         |
> > > +  +-----------------------------------------------------------------=
---------+
> > >
> > >
> > >  In the context of a mailbox framework, a channel refers to a dedicat=
ed
> > >
> > > > +
> > > > +
> > > > +In the context of a mailbox framework, a channel refers to a dedic=
ated
> > > > +communication pathway between two or more processors or components=
. By using
> > > > +channels, the framework abstracts the complexity of interprocessor=
 communication.
> > > > +
> > > > +Data Structures
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +- **struct mbox_client**
> > > > +  This structure represents a client that communicates over a mail=
box
> > > > +  channel. It holds information such as:
> > > > +  - A pointer to the device associated with the client (`dev`).
> > > > +  - Callback functions for handling message transmission events, i=
ncluding:
> > > > +    - `rx_callback`: Called when a message is received.
> > > > +    - `tx_done`: Called when a message transmission is acknowledge=
d.
> > > > +  - Flags that specify the client=E2=80=99s configuration, such as=
 whether it operates
> > > > +    in blocking mode.
> > > > +
> > > > +- **struct mbox_chan**
> > > > +  This structure represents an individual mailbox channel. It main=
tains the
> > > > +  state required for message queuing and transmission. Key members=
 include:
> > > > +  - `msg_data`: Array of messages queued for transmission.
> > > > +  - `msg_count`: Number of messages currently queued.
> > > > +  - `msg_free`: Index of the next free slot in the message queue.
> > > > +  - `active_req`: Pointer to the currently active message being tr=
ansmitted.
> > > > +  - Synchronization primitives to manage access from multiple cont=
exts.
> > > > +
> > > > +- **struct mbox_controller**
> > > > +  This structure represents a mailbox controller that manages mult=
iple
> > > > +  channels. It includes:
> > > > +  - A pointer to the device managing the mailbox.
> > > > +  - Operations for sending and receiving messages, as well as init=
ializing
> > > > +    and shutting down the mailbox.
> > > > +  - A list of associated channels and the total number of channels=
 available.
> > >
> > > Shouldn't these structs be documented as kernel-doc comments? tl;dr:
> > > see Documentation/doc-guide/kernel-doc.html
> > >
> > > > +
> > > > +controller framework APIs
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > +
> > > > +``struct `mbox_controller` Initialization
> > > > +-----------------------------------------
> > >
> > > Properly double-backquote the struct name to format it as inline code=
:
> > >
> > > ---- >8 ----
> > > diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentatio=
n/driver-api/mailbox/core.rst
> > > index 239538f497e41a..d83456164464aa 100644
> > > --- a/Documentation/driver-api/mailbox/core.rst
> > > +++ b/Documentation/driver-api/mailbox/core.rst
> > > @@ -117,7 +117,7 @@ Data Structures
> > >  controller framework APIs
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >
> > > -``struct `mbox_controller` Initialization
> > > +``struct mbox_controller`` Initialization
> > >  -----------------------------------------
> > >
> > >  Just like any other kernel framework, the whole mailbox controller r=
egistration
> > >
> > > > +
> > > > +Just like any other kernel framework, the whole mailbox controller=
 registration
> > > > +relies on the driver filling a structure and registering against t=
he
> > > > +framework. In our case, that structure is mbox_controller.
> > > > +
> > > > +The first thing you need to do in your driver is to allocate this
> > > > +structure. Any of the usual memory allocators will do, but you'll =
also
> > > > +need to initialize a few fields in there:
> > > > +
> > > > +- ``dev``: should hold the pointer to the ``struct device`` associ=
ated
> > > > +  to your current driver instance.
> > > > +
> > > > +- ``ops``: Operators that work on each communication channel.
> > > > +
> > > > +- ``chans``: Array of channels.
> > > > +
> > > > +- ``num_chans``: Number of channels in the `chans` array.
> > > > +
> > > > +- ``txdone_irq``: Indicates if the controller can report to the AP=
I
> > > > +  when the last transmitted data was read by the
> > > > +                          remote (e.g., if it has a TX ACK interru=
pt).
> > > > +
> > > > +All the below fields are not mandatory.
> > > > +
> > > > +- ``txdone_poll``: Indicates if the controller can read but not re=
port
> > > > +                          the TX done. For example, some register =
may show
> > > > +                          the TX status, but no interrupt is raise=
d. This
> > > > +                          field is ignored if `txdone_irq` is set.
> > > > +
> > > > +- ``txpoll_period``: If `txdone_poll` is in effect, the API polls =
for
> > > > +                          the last TX status after this many milli=
seconds.
> > > > +
> > > > +- ``of_xlate``: Controller driver-specific mapping of channel via
> > > > +                          Device Tree (DT).
> > > > +
> > > > +
> > > > +Key Functions
> > > > +-------------
> > > > +
> > > > +- **int devm_mbox_controller_register(struct mbox_controller *mbox=
)**
> > > > +  This function registers a mailbox controller with the kernel. It=
 makes the
> > > > +  channels associated with the controller available for client req=
uests. The
> > > > +  function performs sanity checks on the controller structure to e=
nsure all
> > > > +  necessary fields are populated.
> > > > +
> > > > +- **struct mbox_chan *mbox_request_channel(struct mbox_client *cl,=
 int index)**
> > > > +  This function requests a mailbox channel for a specified client,=
 identified
> > > > +  by an index. It searches for the appropriate mailbox channel, an=
d if found,
> > > > +  it returns a pointer to the channel. If the request fails (e.g.,=
 if the
> > > > +  index is invalid), it returns an error pointer.
> > > > +
> > > > +- **void mbox_free_channel(struct mbox_chan *chan)**
> > > > +  This function releases a mailbox channel that was previously all=
ocated for a
> > > > +  client. It ensures that the channel can be reused by other clien=
ts. If any
> > > > +  messages are still in the queue, they are aborted, and no callba=
cks are made.
> > > > +
> > > > +- **int mbox_send_message(struct mbox_chan *chan, void *mssg)**
> > > > +  This function is used by clients to send a message through the s=
pecified
> > > > +  mailbox channel. The function can operate in either blocking or =
non-blocking
> > > > +  mode, depending on the client=E2=80=99s configuration. It will q=
ueue the message for
> > > > +  transmission and notify the client once the message is acknowled=
ged.
> > > > +
> > > > +- **void mbox_chan_received_data(struct mbox_chan *chan, void *mss=
g)**
> > > > +  This function is called by the controller driver to notify the m=
ailbox
> > > > +  framework that a message has been received on the specified chan=
nel. The
> > > > +  received message is then passed to the appropriate client's `rx_=
callback`
> > > > +  function for processing.
> > >
> > > Shouldn't these functions also be documented as kernel-doc comments?
> > >
> > > > diff --git a/Documentation/driver-api/mailbox/index.rst b/Documenta=
tion/driver-api/mailbox/index.rst
> > > > new file mode 100644
> > > > index 000000000000..e254a8fdb66a
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/mailbox/index.rst
> > > > @@ -0,0 +1,45 @@
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > +Mailbox documentation
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > +
> > > > +Mailbox documentation provides documents for various aspects of ma=
ilbox
> > > > +framework.
> > > > +
> > > > +Mailbox development documentation
> > > > +---------------------------------
> > > > +
> > > > +This book helps with mailbox internal APIs and guide for mailbox d=
evice
> > > > +driver writers.
> > > > +
> > > > +.. toctree::
> > > > +   :maxdepth: 1
> > > > +
> > > > +   core
> > > > +
> > > > +mailbox controller driver documentation
> > > > +------------------------------
> > > > +
> > > > +This book is a guide to device driver writers on how to register
> > > > +mailbox controller to the mailbox framework.
> > > > +
> > > > +.. toctree::
> > > > +   :maxdepth: 1
> > > > +
> > > > +   writing_mailbox_controller_drivers
> > > > +
> > > > +mailbox client driver documentation
> > > > +------------------------------
> > >
> > > Match up section underline length by its title:
> > >
> > > ---- >8 ----
> > > diff --git a/Documentation/driver-api/mailbox/index.rst b/Documentati=
on/driver-api/mailbox/index.rst
> > > index e254a8fdb66ac7..02d7d5e8660999 100644
> > > --- a/Documentation/driver-api/mailbox/index.rst
> > > +++ b/Documentation/driver-api/mailbox/index.rst
> > > @@ -1,6 +1,6 @@
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  Mailbox documentation
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >  Mailbox documentation provides documents for various aspects of mail=
box
> > >  framework.
> > > @@ -17,7 +17,7 @@ driver writers.
> > >     core
> > >
> > >  mailbox controller driver documentation
> > > -------------------------------
> > > +---------------------------------------
> > >
> > >  This book is a guide to device driver writers on how to register
> > >  mailbox controller to the mailbox framework.
> > > @@ -28,7 +28,7 @@ mailbox controller to the mailbox framework.
> > >     writing_mailbox_controller_drivers
> > >
> > >  mailbox client driver documentation
> > > -------------------------------
> > > +-----------------------------------
> > >
> > >  This book is a guide to mailbox client driver writers.
> > >
> > >
> > > > +
> > > > +This book is a guide to mailbox client driver writers.
> > > > +
> > > > +.. toctree::
> > > > +   :maxdepth: 1
> > > > +
> > > > +   client
> > > > +
> > > > +.. only::  subproject and html
> > > > +
> > > > +   Indices
> > > > +   =3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +   * :ref:`genindex`
> > >
> > > Fix up also the reference link on parent toctree:
> > >
> > > ---- >8 ----
> > > diff --git a/Documentation/driver-api/index.rst b/Documentation/drive=
r-api/index.rst
> > > index 7f83e05769b4a4..b4d78b92fd921a 100644
> > > --- a/Documentation/driver-api/index.rst
> > > +++ b/Documentation/driver-api/index.rst
> > > @@ -102,7 +102,7 @@ Subsystem-specific APIs
> > >     ipmb
> > >     ipmi
> > >     libata
> > > -   mailbox
> > > +   mailbox/index
> > >     md/index
> > >     media/index
> > >     mei/index
> > >
> > > > diff --git a/Documentation/driver-api/mailbox/writing_mailbox_contr=
oller_drivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_contro=
ller_drivers.rst
> > > > new file mode 100644
> > > > index 000000000000..2a82645c1357
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_d=
rivers.rst
> > > > @@ -0,0 +1,179 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +.. _writing_mailbox_controller_drivers:
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Writing Mailbox Controller Drivers
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Introduction
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +This document serves as a basic guideline for driver programmers t=
hat need
> > > > +to hack a new mailbox controller driver or understand the essentia=
ls of
> > > > +the existing ones.
> > > > +
> > > > +Driver Boilerplate
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +As a bare minimum, a mailbox controller driver needs to call
> > > > +``mbox_controller_register`` function to register with the framewo=
rk.
> > > > +
> > > > +A basic driver skeleton could look like this for a mailbox hardwar=
e that
> > > > +has the following characteristics:
> > > > +a. It supports only a single channel, i.e., only the remote proces=
sor can
> > > > +   send interrupts.
> > > > +b. Data transfer is over the registers associated with mailbox har=
dware.
> > > > +c. Mailbox hardware is configured to receive interrupts.
> > > > +d. When the remote processor is ready to send data, it triggers a =
mailbox
> > > > +   interrupt.
> > > > +e. As part of interrupt handling by Linux, it copies data from the=
 registers.
> > > > +
> > > > +.. code-block:: c
> > > > +
> > > > +   #include <linux/device.h>
> > > > +   #include <linux/interrupt.h>
> > > > +   #include <linux/io.h>
> > > > +   #include <linux/kernel.h>
> > > > +   #include <linux/mailbox_controller.h>
> > > > +   #include <linux/module.h>
> > > > +   #include <linux/of.h>
> > > > +   #include <linux/platform_device.h>
> > > > +   #define DRIVER_NAME "dummy_controller"
> > > > +
> > > > +   struct dummy_mbox {
> > > > +       struct device *dev;
> > > > +       struct mbox_controller controller;
> > > > +       int irq;
> > > > +   };
> > > > +
> > > > +   static void dummy_mbox_receive(struct mbox_chan *chan)
> > > > +   {
> > > > +       struct dummy_mbox *mbox =3D chan->con_priv;
> > > > +       int val;
> > > > +
> > > > +       // Data copied from registers
> > > > +       val =3D read_register();
> > > > +       mbox_chan_received_data(chan, &val);
> > > > +   }
> > > > +
> > > > +   static irqreturn_t dummy_mbox_irq_handler(int irq, void *data)
> > > > +   {
> > > > +       struct mbox_chan *chan =3D data;
> > > > +       struct dummy_mbox *mbox =3D chan->con_priv;
> > > > +       u32 reg;
> > > > +
> > > > +       // Read registers to see if data is received
> > > > +       dummy_mbox_receive(chan);
> > > > +       mbox_chan_txdone(chan, 0);
> > > > +       return reg ? IRQ_HANDLED : IRQ_NONE;
> > > > +   }
> > > > +
> > > > +   static int dummy_mbox_send_data(struct mbox_chan *chan, void *d=
ata)
> > > > +   {
> > > > +       // Write data in registers to send it to the remote process=
or
> > > > +       return 0;
> > > > +   }
> > > > +
> > > > +   static int dummy_mbox_startup(struct mbox_chan *chan)
> > > > +   {
> > > > +       struct dummy_mbox *mbox =3D chan->con_priv;
> > > > +       u32 reg;
> > > > +       int ret;
> > > > +
> > > > +       ret =3D devm_request_irq(mbox->dev, mbox->irq, dummy_mbox_i=
rq_handler, 0,
> > > > +               DRIVER_NAME, chan);
> > > > +       if (ret < 0) {
> > > > +           dev_err(mbox->dev, "Cannot request irq\n");
> > > > +           return ret;
> > > > +       }
> > > > +
> > > > +       /* Register write to enable IRQ generation */
> > > > +
> > > > +       return 0;
> > > > +   }
> > > > +
> > > > +   static void dummy_mbox_shutdown(struct mbox_chan *chan)
> > > > +   {
> > > > +       struct dummy_mbox *mbox =3D chan->con_priv;
> > > > +
> > > > +       /* Disable interrupt generation */
> > > > +       devm_free_irq(mbox->dev, mbox->irq, chan);
> > > > +   }
> > > > +
> > > > +   static const struct mbox_chan_ops dummy_mbox_ops =3D {
> > > > +       .send_data =3D dummy_mbox_send_data,
> > > > +       .startup =3D dummy_mbox_startup,
> > > > +       .shutdown =3D dummy_mbox_shutdown,
> > > > +   };
> > > > +
> > > > +   static int dummy_mbox_probe(struct platform_device *pdev)
> > > > +   {
> > > > +       struct dummy_mbox *mbox;
> > > > +       struct mbox_chan *chans;
> > > > +       int ret;
> > > > +
> > > > +       mbox =3D devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL=
);
> > > > +       if (!mbox)
> > > > +           return -ENOMEM;
> > > > +
> > > > +       /* Allocate one channel */
> > > > +       chans =3D devm_kzalloc(&pdev->dev, sizeof(*chans), GFP_KERN=
EL);
> > > > +       if (!chans)
> > > > +           return -ENOMEM;
> > > > +
> > > > +       mbox->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > > +       if (IS_ERR(mbox->base))
> > > > +           return PTR_ERR(mbox->base);
> > > > +
> > > > +       mbox->irq =3D platform_get_irq(pdev, 0);
> > > > +       if (mbox->irq < 0)
> > > > +           return mbox->irq;
> > > > +
> > > > +       mbox->dev =3D &pdev->dev;
> > > > +
> > > > +       /* Hardware supports only one channel. */
> > > > +       mbox->controller.dev =3D mbox->dev;
> > > > +       mbox->controller.num_chans =3D 1;
> > > > +       mbox->controller.chans =3D chans;
> > > > +       mbox->controller.ops =3D &dummy_mbox_ops;
> > > > +       mbox->controller.txdone_irq =3D true;
> > > > +
> > > > +       ret =3D devm_mbox_controller_register(mbox->dev, &mbox->con=
troller);
> > > > +       if (ret) {
> > > > +           dev_err(&pdev->dev, "Could not register mailbox control=
ler\n");
> > > > +           return ret;
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +   }
> > > > +
> > > > +   static const struct of_device_id dummy_mbox_match[] =3D {
> > > > +       { .compatible =3D "dummy,dummy-mailbox" },
> > > > +       { },
> > > > +   };
> > > > +
> > > > +   MODULE_DEVICE_TABLE(of, dummy_mbox_match);
> > > > +
> > > > +   static struct platform_driver dummy_mbox_driver =3D {
> > > > +       .probe =3D dummy_mbox_probe,
> > > > +       .driver =3D {
> > > > +           .name =3D DRIVER_NAME,
> > > > +           .of_match_table =3D dummy_mbox_match,
> > > > +       },
> > > > +   };
> > > > +
> > > > +   module_platform_driver(dummy_mbox_driver);
> > > > +   MODULE_LICENSE("GPL v2");
> > > > +   MODULE_DESCRIPTION("Dummy mailbox controller driver");
> > > > +
> > > > +In the above code, a couple of things are done:
> > > > +a. The controller is registered in the probe along with callbacks,=
 which in
> > > > +   this case are the bare minimum: ``startup``, ``shutdown``, and
> > > > +   ``send_data``.
> > > > +b. IRQ is registered to get notifications from the remote processo=
r.
> > > > +c. In the IRQ handler, registers are read to copy data, and
> > > > +   ``mbox_chan_received_data`` is called to hand over the data to =
the client.
> > > > +d. ``mbox_chan_txdone`` is called to let the framework know that t=
his data
> > > > +   is the last data and no more data is to be expected for the cur=
rent transfer.
> > > > +
> > >
> > > Sphinx warns out numerous indentation warnings on the lists, so I hav=
e to
> > > fix them up:
> > >
> > > ---- >8 ----
> > > diff --git a/Documentation/driver-api/mailbox/client.rst b/Documentat=
ion/driver-api/mailbox/client.rst
> > > index 9088f83734230d..17dafaca056777 100644
> > > --- a/Documentation/driver-api/mailbox/client.rst
> > > +++ b/Documentation/driver-api/mailbox/client.rst
> > > @@ -31,6 +31,7 @@ The mailbox structure is defined as follows:
> > >  Key Functions
> > >  -------------
> > >  1. Requesting a Mailbox Channel
> > > +
> > >     - **Function**: `mbox_request_channel(struct mbox_client *client,
> > >       unsigned int channel)`
> > >     - **Description**: Requests a mailbox channel for sending message=
s.
> > > @@ -41,15 +42,19 @@ Key Functions
> > >       code on failure.
> > >
> > >  2. Sending a Message
> > > +
> > >     - **Function**: `mbox_send_message(struct mbox_chan *chan, void *=
msg)`
> > >     - **Description**: Sends a message through the mailbox channel.
> > >     - **Parameters**:
> > > +
> > >       - `chan`: The mailbox channel used for communication.
> > >       - `msg`: Pointer to the message to be sent (usually NULL for du=
mmy
> > >         messages).
> > > +
> > >     - **Returns**: 0 on success, or a negative error code on failure.
> > >
> > >  3. Transmitting Completion
> > > +
> > >     - **Function**: `mbox_client_txdone(struct mbox_chan *chan, unsig=
ned int
> > >       msg_id)`
> > >     - **Description**: Notifies the mailbox framework that message
> > > diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentatio=
n/driver-api/mailbox/core.rst
> > > index 8d56d81007c11c..239538f497e41a 100644
> > > --- a/Documentation/driver-api/mailbox/core.rst
> > > +++ b/Documentation/driver-api/mailbox/core.rst
> > > @@ -85,16 +85,20 @@ Data Structures
> > >  - **struct mbox_client**
> > >    This structure represents a client that communicates over a mailbo=
x
> > >    channel. It holds information such as:
> > > +
> > >    - A pointer to the device associated with the client (`dev`).
> > >    - Callback functions for handling message transmission events, inc=
luding:
> > > +
> > >      - `rx_callback`: Called when a message is received.
> > >      - `tx_done`: Called when a message transmission is acknowledged.
> > > +
> > >    - Flags that specify the client=E2=80=99s configuration, such as w=
hether it operates
> > >      in blocking mode.
> > >
> > >  - **struct mbox_chan**
> > >    This structure represents an individual mailbox channel. It mainta=
ins the
> > >    state required for message queuing and transmission. Key members i=
nclude:
> > > +
> > >    - `msg_data`: Array of messages queued for transmission.
> > >    - `msg_count`: Number of messages currently queued.
> > >    - `msg_free`: Index of the next free slot in the message queue.
> > > @@ -104,6 +108,7 @@ Data Structures
> > >  - **struct mbox_controller**
> > >    This structure represents a mailbox controller that manages multip=
le
> > >    channels. It includes:
> > > +
> > >    - A pointer to the device managing the mailbox.
> > >    - Operations for sending and receiving messages, as well as initia=
lizing
> > >      and shutting down the mailbox.
> > > @@ -133,21 +138,20 @@ need to initialize a few fields in there:
> > >  - ``num_chans``: Number of channels in the `chans` array.
> > >
> > >  - ``txdone_irq``: Indicates if the controller can report to the API
> > > -  when the last transmitted data was read by the
> > > -                          remote (e.g., if it has a TX ACK interrupt=
).
> > > +  when the last transmitted data was read by the remote (e.g., if it=
 has a
> > > +  TX ACK interrupt).
> > >
> > >  All the below fields are not mandatory.
> > >
> > >  - ``txdone_poll``: Indicates if the controller can read but not repo=
rt
> > > -                          the TX done. For example, some register ma=
y show
> > > -                          the TX status, but no interrupt is raised.=
 This
> > > -                          field is ignored if `txdone_irq` is set.
> > > +  the TX done. For example, some register may show the TX status, bu=
t no
> > > +  interrupt is raised. This field is ignored if `txdone_irq` is set.
> > >
> > >  - ``txpoll_period``: If `txdone_poll` is in effect, the API polls fo=
r
> > > -                          the last TX status after this many millise=
conds.
> > > +  the last TX status after this many milliseconds.
> > >
> > >  - ``of_xlate``: Controller driver-specific mapping of channel via
> > > -                          Device Tree (DT).
> > > +  Device Tree (DT).
> > >
> > >
> > >  Key Functions
> > > diff --git a/Documentation/driver-api/mailbox/writing_mailbox_control=
ler_drivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_controll=
er_drivers.rst
> > > index 2a82645c13573e..853adf6918173d 100644
> > > --- a/Documentation/driver-api/mailbox/writing_mailbox_controller_dri=
vers.rst
> > > +++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_dri=
vers.rst
> > > @@ -21,6 +21,7 @@ As a bare minimum, a mailbox controller driver need=
s to call
> > >
> > >  A basic driver skeleton could look like this for a mailbox hardware =
that
> > >  has the following characteristics:
> > > +
> > >  a. It supports only a single channel, i.e., only the remote processo=
r can
> > >     send interrupts.
> > >  b. Data transfer is over the registers associated with mailbox hardw=
are.
> > > @@ -168,6 +169,7 @@ e. As part of interrupt handling by Linux, it cop=
ies data from the registers.
> > >     MODULE_DESCRIPTION("Dummy mailbox controller driver");
> > >
> > >  In the above code, a couple of things are done:
> > > +
> > >  a. The controller is registered in the probe along with callbacks, w=
hich in
> > >     this case are the bare minimum: ``startup``, ``shutdown``, and
> > >     ``send_data``.
> > >
> > > Thanks.
> > >
> > > --
> > > An old man doll... just what I always wanted! - Clara

