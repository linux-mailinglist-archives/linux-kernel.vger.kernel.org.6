Return-Path: <linux-kernel+bounces-380514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC989AEFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98211F24955
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B502003B4;
	Thu, 24 Oct 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT7SY47g"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8715957D;
	Thu, 24 Oct 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795343; cv=none; b=hEjEhn2/IfdU5I/0hIqR0xbswSm44kiruB0L32MzWv3c3Sc66j0CMvno7jh6laN5QZ7Ji+sblTXXF+l7yUr3T5LqT87tfXNi3xFjUWkn1hQ65pVSys07ciixMAguVkLOzb6MjlT4Os7S6W9VaDHKuvvXEILXXhdzby9scJ/rgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795343; c=relaxed/simple;
	bh=SKHEhDJjBvpSYnfoX7aE+xLXUIi2PwR0i8o1owYyZLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2l+onNenar6kq8uzbszH3wuN2L3pWvacTAXWV6wffPPdTjs8DZRvOIukjhdamncU2uuGW6J6r9AqCi8MBG5psaFuXGw9Re+QIfkITMIK//fj7jvQuuxQV4wqCqakh/+ksZxpEveXhutfkY3LdiaX/vtEEmaq0O9N7GXiEAo6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT7SY47g; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so12537481fa.3;
        Thu, 24 Oct 2024 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795337; x=1730400137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myZ0Ln4GxagVYy2X7Jq63kXoxyTxEBQL9Q4gCF9QWg0=;
        b=AT7SY47gGdqAho5ZQUCWGsdedKYcLF/Ze1hj7Sn2fCgEcGeFyGAjX0KsjhKV8zEvZg
         Y9tJtwdycLqp1Fh6mNPUKWR5iLNQVgloG9YNv5Si/HMMrKMo0HhvR82UH5N9l3ziKtP5
         OX2K9lM3S2Yl5dRStKkrSdVktFOctcIGHofxLI0OvVpSBs5eY57oU5g2GcyOvzYkNpob
         bU0myHmse7zaAJo3Hhmhjv4//0Ag9AogTbi3r6lonWzxndNfIi3mXCty0TzhpwMpitFt
         uXzX0jWk852I8ZsQtTUpQizsRTFOsamw0Iw2tMgs79BBX5EivbGVNFbM9+19jlxmCnlj
         EzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795337; x=1730400137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myZ0Ln4GxagVYy2X7Jq63kXoxyTxEBQL9Q4gCF9QWg0=;
        b=WIgefY9K0aphiFxpaE+gbohcOhcvFwjU+VE7mY8Cnv1i5bsIVWTHq7AEnNfpHlIubQ
         vPcgqDC6SZsIe2EEhKLfRXwkC/i6xbd5ZJvN3obDn5Y4+zUNWqD6cKbPCNDKu69To8eO
         9PQOgYnBCWX3WdPGsLbCgTvB2MSNLtdQ8XePNClelpDk1mmCcKzpRMtQYlWn3MCE9iIK
         Wd3cQDsQGXGJhZ+bJrnxhwQnKhhK9Va/WCYiHVlk6F1W2hcwGbaSC1au5sHzNUGocQIm
         GprRZYGT2rRMFqhxtrBydAZPVBmVJ+lsNvCEwmCy2t/Rehozkpnal/hN48JyEFAvd5vv
         XANQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0YBbBi6cF4bWVLM3icP0lfsQ0HPqBNqdfxbxnz3aih9g2cgTO7oqiddjyXAyqYeJqRNLPT5tHyIEpfi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5OZ0r9hkszCRwel8eDoGqo/9rVjJtMmcgofJm7SPquRaZVmM
	JhDrfWdEggtIl8m0h3qRKTPKL3uge+m4Iqgns+oco428r5kIGkreUZO0478hPk7puatayQodXtj
	Jx6dM0mcHjx5Fvnxf1cwxzRpP9H4=
X-Google-Smtp-Source: AGHT+IHH+Dhzl0vUcDVIcjrX6/ooOeC92V9Gck6rkQ497Vey9vl/wpFjjaRpQGjaIc4XtcrBkqnbxm9mtXX8f4SNPtA=
X-Received: by 2002:a2e:6102:0:b0:2fb:3a92:d1a7 with SMTP id
 38308e7fff4ca-2fca8264a6fmr17145481fa.33.1729795337004; Thu, 24 Oct 2024
 11:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019195534.79603-1-yesanishhere@gmail.com> <20241019195534.79603-2-yesanishhere@gmail.com>
In-Reply-To: <20241019195534.79603-2-yesanishhere@gmail.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 24 Oct 2024 11:42:05 -0700
Message-ID: <CABCoZhAR3X7YthDuXVZ517Sg0YOdtU_59eT1GNr7LT-EGfC0+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
To: jassisinghbrar@gmail.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jassi,

Wondering if you have any comments. Thanks.

On Sat, Oct 19, 2024 at 12:55=E2=80=AFPM anish kumar <yesanishhere@gmail.co=
m> wrote:
>
> 1. added client documentation
> 2. added controller documentation.
> 3. added framework documentation
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/mailbox/client.rst   | 192 ++++++++++++++++++
>  Documentation/driver-api/mailbox/core.rst     | 182 +++++++++++++++++
>  Documentation/driver-api/mailbox/index.rst    |  45 ++++
>  .../writing_mailbox_controller_drivers.rst    | 179 ++++++++++++++++
>  4 files changed, 598 insertions(+)
>  create mode 100644 Documentation/driver-api/mailbox/client.rst
>  create mode 100644 Documentation/driver-api/mailbox/core.rst
>  create mode 100644 Documentation/driver-api/mailbox/index.rst
>  create mode 100644 Documentation/driver-api/mailbox/writing_mailbox_cont=
roller_drivers.rst
>
> diff --git a/Documentation/driver-api/mailbox/client.rst b/Documentation/=
driver-api/mailbox/client.rst
> new file mode 100644
> index 000000000000..9088f8373423
> --- /dev/null
> +++ b/Documentation/driver-api/mailbox/client.rst
> @@ -0,0 +1,192 @@
> +Mailbox Client Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Overview
> +--------
> +The mailbox client driver is responsible for sending and receiving messa=
ges
> +to and from a remote processor. It uses mailbox APIs provided by the
> +mailbox framework.
> +
> +Mailbox Structure
> +-----------------
> +The mailbox structure is defined as follows:
> +
> +.. code-block:: c
> +
> +   struct mbox_client {
> +       //device associated with the mailbox
> +       struct device *dev;
> +       // callback for transmission completion
> +       void (*tx_done)(struct mbox_client *client);
> +       // callback to prepare for sending a message
> +       void (*tx_prepare)(struct mbox_client *client);
> +       // callback for received messages
> +       void (*rx_callback)(struct mbox_client *client, void *data);
> +       // flag to indicate if transmission should block
> +       bool tx_block;
> +       // indicates if the client knows when transmission is done
> +       bool knows_txdone;
> +   };
> +
> +Key Functions
> +-------------
> +1. Requesting a Mailbox Channel
> +   - **Function**: `mbox_request_channel(struct mbox_client *client,
> +     unsigned int channel)`
> +   - **Description**: Requests a mailbox channel for sending messages.
> +   - **Parameters**:
> +     - `client`: Pointer to the mailbox client structure.
> +     - `channel`: The specific mailbox channel to request.
> +   - **Returns**: A pointer to the mailbox channel on success, or an err=
or
> +     code on failure.
> +
> +2. Sending a Message
> +   - **Function**: `mbox_send_message(struct mbox_chan *chan, void *msg)=
`
> +   - **Description**: Sends a message through the mailbox channel.
> +   - **Parameters**:
> +     - `chan`: The mailbox channel used for communication.
> +     - `msg`: Pointer to the message to be sent (usually NULL for dummy
> +       messages).
> +   - **Returns**: 0 on success, or a negative error code on failure.
> +
> +3. Transmitting Completion
> +   - **Function**: `mbox_client_txdone(struct mbox_chan *chan, unsigned =
int
> +     msg_id)`
> +   - **Description**: Notifies the mailbox framework that message
> +     transmission is complete.
> +   - **Parameters**:
> +     - `chan`: The mailbox channel associated with the message.
> +     - `msg_id`: The identifier of the message that was transmitted.
> +
> +Usage Example
> +-------------
> +In a typical mailbox client driver, the following steps are typically
> +performed:
> +
> +1. Initialize the Mailbox Client:
> +
> +   .. code-block:: c
> +
> +      struct mbox_client my_mbox_client =3D {
> +          .dev =3D &my_device,
> +          .tx_done =3D my_tx_done_callback,
> +          .rx_callback =3D my_rx_callback,
> +          .tx_block =3D false,
> +          .knows_txdone =3D true,
> +      };
> +
> +2. Request a Mailbox Channel:
> +
> +   .. code-block:: c
> +
> +      mbox_chan =3D mbox_request_channel(&my_mbox_client, 0);
> +      if (IS_ERR(mbox_chan)) {
> +          // Handle error
> +      }
> +
> +3. Send a Message:
> +
> +   .. code-block:: c
> +
> +      int ret =3D mbox_send_message(mbox_chan, NULL); // Sending a dummy=
 message
> +      if (ret < 0) {
> +          // Handle error
> +      }
> +
> +4. Complete Transmission:
> +
> +   .. code-block:: c
> +
> +      mbox_client_txdone(mbox_chan, 0);
> +
> +Interrupt Handling
> +------------------
> +The mailbox interface can trigger interrupts upon message receipt. Handl=
ers
> +should be implemented in the `rx_callback` function defined in the mailb=
ox
> +client structure to process incoming messages.
> +
> +Example Mailbox Client Driver
> +-----------------------------
> +.. code-block:: c
> +
> +   struct demo_client {
> +       struct mbox_client cl;
> +       struct mbox_chan *mbox;
> +       struct completion c;
> +       bool async;
> +       /* ... */
> +   };
> +
> +   /*
> +   * This is the handler for data received from remote. The behaviour is=
 purely
> +   * dependent upon the protocol. This is just an example.
> +   */
> +   static void message_from_remote(struct mbox_client *cl, void *mssg)
> +   {
> +       struct demo_client *dc =3D container_of(cl, struct demo_client, c=
l);
> +       if (dc->async) {
> +           if (is_an_ack(mssg)) {
> +               /* An ACK to our last sample sent */
> +               return; /* Or do something else here */
> +           } else { /* A new message from remote */
> +               queue_req(mssg);
> +           }
> +       } else {
> +           /* Remote f/w sends only ACK packets on this channel */
> +           return;
> +       }
> +   }
> +
> +   static void sample_sent(struct mbox_client *cl, void *mssg, int r)
> +   {
> +       struct demo_client *dc =3D container_of(cl, struct demo_client, c=
l);
> +       complete(&dc->c);
> +   }
> +
> +   static void client_demo(struct platform_device *pdev)
> +   {
> +       struct demo_client *dc_sync, *dc_async;
> +       /* The controller already knows async_pkt and sync_pkt */
> +       struct async_pkt ap;
> +       struct sync_pkt sp;
> +
> +       dc_sync =3D kzalloc(sizeof(*dc_sync), GFP_KERNEL);
> +       dc_async =3D kzalloc(sizeof(*dc_async), GFP_KERNEL);
> +
> +       /* Populate non-blocking mode client */
> +       dc_async->cl.dev =3D &pdev->dev;
> +       dc_async->cl.rx_callback =3D message_from_remote;
> +       dc_async->cl.tx_done =3D sample_sent;
> +       dc_async->cl.tx_block =3D false;
> +       dc_async->cl.tx_tout =3D 0; /* doesn't matter here */
> +       dc_async->cl.knows_txdone =3D false; /* depending upon protocol *=
/
> +       dc_async->async =3D true;
> +       init_completion(&dc_async->c);
> +
> +       /* Populate blocking mode client */
> +       dc_sync->cl.dev =3D &pdev->dev;
> +       dc_sync->cl.rx_callback =3D message_from_remote;
> +       dc_sync->cl.tx_done =3D NULL; /* operate in blocking mode */
> +       dc_sync->cl.tx_block =3D true;
> +       dc_sync->cl.tx_tout =3D 500; /* by half a second */
> +       dc_sync->cl.knows_txdone =3D false; /* depending upon protocol */
> +       dc_sync->async =3D false;
> +
> +       /* ASync mailbox is listed second in 'mboxes' property */
> +       dc_async->mbox =3D mbox_request_channel(&dc_async->cl, 1);
> +       /* Populate data packet */
> +       /* ap.xxx =3D 123; etc */
> +       /* Send async message to remote */
> +       mbox_send_message(dc_async->mbox, &ap);
> +
> +       /* Sync mailbox is listed first in 'mboxes' property */
> +       dc_sync->mbox =3D mbox_request_channel(&dc_sync->cl, 0);
> +       /* Populate data packet */
> +       /* sp.abc =3D 123; etc */
> +       /* Send message to remote in blocking mode */
> +       mbox_send_message(dc_sync->mbox, &sp);
> +       /* At this point 'sp' has been sent */
> +
> +       /* Now wait for async chan to be done */
> +       wait_for_completion(&dc_async->c);
> +   }
> diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentation/dr=
iver-api/mailbox/core.rst
> new file mode 100644
> index 000000000000..d1220086da67
> --- /dev/null
> +++ b/Documentation/driver-api/mailbox/core.rst
> @@ -0,0 +1,182 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +mailbox documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Hardware Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Mailbox hardware is a specialized component found in multi-core
> +processors and embedded systems that facilitates inter-processor
> +communication (IPC) or communication between different hardware
> +components. It provides a structured mechanism for sending and
> +receiving messages, allowing various processors or devices to
> +exchange data efficiently. Here's an overview of its key
> +characteristics and functions:
> +
> +Key Characteristics of Mailbox Hardware
> +Interrupt Handling: Many mailbox implementations support
> +interrupt-driven communication. This allows a receiving processor
> +to be alerted when a new message arrives, facilitating immediate
> +processing without polling the mailbox constantly.
> +
> +Hardware Registers: Mailbox hardware often includes registers for
> +configuration and status monitoring. These registers can be used
> +to control the mailbox's behavior, check for available messages,
> +or acknowledge message receipt.
> +
> +Support for Multiple Protocols: Mailboxes can support various
> +communication protocols, enabling interoperability between different
> +hardware components and simplifying the integration of diverse systems.
> +
> +Synchronous and Asynchronous Modes: Mailbox hardware can operate in
> +both synchronous and asynchronous modes. In synchronous mode, the
> +sender may wait for the receiver to acknowledge receipt before
> +proceeding, while in asynchronous mode, the sender can continue
> +executing other tasks immediately after sending the message.
> +
> +
> +Mailbox framework design
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The mailbox facilitates interprocessor communication by allowing process=
ors to
> +exchange messages or signals. The mailbox framework consists of:
> +
> +Mailbox Controller: This is platform-specific and is responsible for con=
figuring
> +and managing interrupts from the remote processor. It offers a generic A=
PI for
> +the mailbox client.
> +
> +Mailbox Client: This component handles the sending and receiving of mess=
ages.
> +
> +
> +........................................................................=
....
> +:  client driver      client_a            client_b                      =
   :
> +........................................................................=
....
> +                            ^-------------------^
> +                                    |
> +                                    |
> +........................................................................=
....
> +:  controller framework          mailbox                                =
   :
> +....................................|...................................=
....
> +                                    |
> +                                    |
> +........................................................................=
....
> +:  controller driver          device specific                           =
   :
> +....................................|...................................=
....
> +                                    |
> +                                    |
> +kernel                              |
> +........................................................................=
....
> +hardware                            |
> +                                    |
> +                                    |
> +........................................................................=
....
> +:                             remote processor                          =
   :
> +........................................................................=
....
> +
> +
> +In the context of a mailbox framework, a channel refers to a dedicated
> +communication pathway between two or more processors or components. By u=
sing
> +channels, the framework abstracts the complexity of interprocessor commu=
nication.
> +
> +Data Structures
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- **struct mbox_client**
> +  This structure represents a client that communicates over a mailbox
> +  channel. It holds information such as:
> +  - A pointer to the device associated with the client (`dev`).
> +  - Callback functions for handling message transmission events, includi=
ng:
> +    - `rx_callback`: Called when a message is received.
> +    - `tx_done`: Called when a message transmission is acknowledged.
> +  - Flags that specify the client=E2=80=99s configuration, such as wheth=
er it operates
> +    in blocking mode.
> +
> +- **struct mbox_chan**
> +  This structure represents an individual mailbox channel. It maintains =
the
> +  state required for message queuing and transmission. Key members inclu=
de:
> +  - `msg_data`: Array of messages queued for transmission.
> +  - `msg_count`: Number of messages currently queued.
> +  - `msg_free`: Index of the next free slot in the message queue.
> +  - `active_req`: Pointer to the currently active message being transmit=
ted.
> +  - Synchronization primitives to manage access from multiple contexts.
> +
> +- **struct mbox_controller**
> +  This structure represents a mailbox controller that manages multiple
> +  channels. It includes:
> +  - A pointer to the device managing the mailbox.
> +  - Operations for sending and receiving messages, as well as initializi=
ng
> +    and shutting down the mailbox.
> +  - A list of associated channels and the total number of channels avail=
able.
> +
> +controller framework APIs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +``struct `mbox_controller` Initialization
> +-----------------------------------------
> +
> +Just like any other kernel framework, the whole mailbox controller regis=
tration
> +relies on the driver filling a structure and registering against the
> +framework. In our case, that structure is mbox_controller.
> +
> +The first thing you need to do in your driver is to allocate this
> +structure. Any of the usual memory allocators will do, but you'll also
> +need to initialize a few fields in there:
> +
> +- ``dev``: should hold the pointer to the ``struct device`` associated
> +  to your current driver instance.
> +
> +- ``ops``: Operators that work on each communication channel.
> +
> +- ``chans``: Array of channels.
> +
> +- ``num_chans``: Number of channels in the `chans` array.
> +
> +- ``txdone_irq``: Indicates if the controller can report to the API
> +  when the last transmitted data was read by the
> +                          remote (e.g., if it has a TX ACK interrupt).
> +
> +All the below fields are not mandatory.
> +
> +- ``txdone_poll``: Indicates if the controller can read but not report
> +                          the TX done. For example, some register may sh=
ow
> +                          the TX status, but no interrupt is raised. Thi=
s
> +                          field is ignored if `txdone_irq` is set.
> +
> +- ``txpoll_period``: If `txdone_poll` is in effect, the API polls for
> +                          the last TX status after this many millisecond=
s.
> +
> +- ``of_xlate``: Controller driver-specific mapping of channel via
> +                          Device Tree (DT).
> +
> +
> +Key Functions
> +-------------
> +
> +- **int devm_mbox_controller_register(struct mbox_controller *mbox)**
> +  This function registers a mailbox controller with the kernel. It makes=
 the
> +  channels associated with the controller available for client requests.=
 The
> +  function performs sanity checks on the controller structure to ensure =
all
> +  necessary fields are populated.
> +
> +- **struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int i=
ndex)**
> +  This function requests a mailbox channel for a specified client, ident=
ified
> +  by an index. It searches for the appropriate mailbox channel, and if f=
ound,
> +  it returns a pointer to the channel. If the request fails (e.g., if th=
e
> +  index is invalid), it returns an error pointer.
> +
> +- **void mbox_free_channel(struct mbox_chan *chan)**
> +  This function releases a mailbox channel that was previously allocated=
 for a
> +  client. It ensures that the channel can be reused by other clients. If=
 any
> +  messages are still in the queue, they are aborted, and no callbacks ar=
e made.
> +
> +- **int mbox_send_message(struct mbox_chan *chan, void *mssg)**
> +  This function is used by clients to send a message through the specifi=
ed
> +  mailbox channel. The function can operate in either blocking or non-bl=
ocking
> +  mode, depending on the client=E2=80=99s configuration. It will queue t=
he message for
> +  transmission and notify the client once the message is acknowledged.
> +
> +- **void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)**
> +  This function is called by the controller driver to notify the mailbox
> +  framework that a message has been received on the specified channel. T=
he
> +  received message is then passed to the appropriate client's `rx_callba=
ck`
> +  function for processing.
> diff --git a/Documentation/driver-api/mailbox/index.rst b/Documentation/d=
river-api/mailbox/index.rst
> new file mode 100644
> index 000000000000..e254a8fdb66a
> --- /dev/null
> +++ b/Documentation/driver-api/mailbox/index.rst
> @@ -0,0 +1,45 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Mailbox documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Mailbox documentation provides documents for various aspects of mailbox
> +framework.
> +
> +Mailbox development documentation
> +---------------------------------
> +
> +This book helps with mailbox internal APIs and guide for mailbox device
> +driver writers.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   core
> +
> +mailbox controller driver documentation
> +------------------------------
> +
> +This book is a guide to device driver writers on how to register
> +mailbox controller to the mailbox framework.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   writing_mailbox_controller_drivers
> +
> +mailbox client driver documentation
> +------------------------------
> +
> +This book is a guide to mailbox client driver writers.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   client
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =3D=3D=3D=3D=3D=3D=3D
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/driver-api/mailbox/writing_mailbox_controller_=
drivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_controller_d=
rivers.rst
> new file mode 100644
> index 000000000000..2a82645c1357
> --- /dev/null
> +++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers=
.rst
> @@ -0,0 +1,179 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _writing_mailbox_controller_drivers:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Writing Mailbox Controller Drivers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document serves as a basic guideline for driver programmers that ne=
ed
> +to hack a new mailbox controller driver or understand the essentials of
> +the existing ones.
> +
> +Driver Boilerplate
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +As a bare minimum, a mailbox controller driver needs to call
> +``mbox_controller_register`` function to register with the framework.
> +
> +A basic driver skeleton could look like this for a mailbox hardware that
> +has the following characteristics:
> +a. It supports only a single channel, i.e., only the remote processor ca=
n
> +   send interrupts.
> +b. Data transfer is over the registers associated with mailbox hardware.
> +c. Mailbox hardware is configured to receive interrupts.
> +d. When the remote processor is ready to send data, it triggers a mailbo=
x
> +   interrupt.
> +e. As part of interrupt handling by Linux, it copies data from the regis=
ters.
> +
> +.. code-block:: c
> +
> +   #include <linux/device.h>
> +   #include <linux/interrupt.h>
> +   #include <linux/io.h>
> +   #include <linux/kernel.h>
> +   #include <linux/mailbox_controller.h>
> +   #include <linux/module.h>
> +   #include <linux/of.h>
> +   #include <linux/platform_device.h>
> +   #define DRIVER_NAME "dummy_controller"
> +
> +   struct dummy_mbox {
> +       struct device *dev;
> +       struct mbox_controller controller;
> +       int irq;
> +   };
> +
> +   static void dummy_mbox_receive(struct mbox_chan *chan)
> +   {
> +       struct dummy_mbox *mbox =3D chan->con_priv;
> +       int val;
> +
> +       // Data copied from registers
> +       val =3D read_register();
> +       mbox_chan_received_data(chan, &val);
> +   }
> +
> +   static irqreturn_t dummy_mbox_irq_handler(int irq, void *data)
> +   {
> +       struct mbox_chan *chan =3D data;
> +       struct dummy_mbox *mbox =3D chan->con_priv;
> +       u32 reg;
> +
> +       // Read registers to see if data is received
> +       dummy_mbox_receive(chan);
> +       mbox_chan_txdone(chan, 0);
> +       return reg ? IRQ_HANDLED : IRQ_NONE;
> +   }
> +
> +   static int dummy_mbox_send_data(struct mbox_chan *chan, void *data)
> +   {
> +       // Write data in registers to send it to the remote processor
> +       return 0;
> +   }
> +
> +   static int dummy_mbox_startup(struct mbox_chan *chan)
> +   {
> +       struct dummy_mbox *mbox =3D chan->con_priv;
> +       u32 reg;
> +       int ret;
> +
> +       ret =3D devm_request_irq(mbox->dev, mbox->irq, dummy_mbox_irq_han=
dler, 0,
> +               DRIVER_NAME, chan);
> +       if (ret < 0) {
> +           dev_err(mbox->dev, "Cannot request irq\n");
> +           return ret;
> +       }
> +
> +       /* Register write to enable IRQ generation */
> +
> +       return 0;
> +   }
> +
> +   static void dummy_mbox_shutdown(struct mbox_chan *chan)
> +   {
> +       struct dummy_mbox *mbox =3D chan->con_priv;
> +
> +       /* Disable interrupt generation */
> +       devm_free_irq(mbox->dev, mbox->irq, chan);
> +   }
> +
> +   static const struct mbox_chan_ops dummy_mbox_ops =3D {
> +       .send_data =3D dummy_mbox_send_data,
> +       .startup =3D dummy_mbox_startup,
> +       .shutdown =3D dummy_mbox_shutdown,
> +   };
> +
> +   static int dummy_mbox_probe(struct platform_device *pdev)
> +   {
> +       struct dummy_mbox *mbox;
> +       struct mbox_chan *chans;
> +       int ret;
> +
> +       mbox =3D devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +       if (!mbox)
> +           return -ENOMEM;
> +
> +       /* Allocate one channel */
> +       chans =3D devm_kzalloc(&pdev->dev, sizeof(*chans), GFP_KERNEL);
> +       if (!chans)
> +           return -ENOMEM;
> +
> +       mbox->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mbox->base))
> +           return PTR_ERR(mbox->base);
> +
> +       mbox->irq =3D platform_get_irq(pdev, 0);
> +       if (mbox->irq < 0)
> +           return mbox->irq;
> +
> +       mbox->dev =3D &pdev->dev;
> +
> +       /* Hardware supports only one channel. */
> +       mbox->controller.dev =3D mbox->dev;
> +       mbox->controller.num_chans =3D 1;
> +       mbox->controller.chans =3D chans;
> +       mbox->controller.ops =3D &dummy_mbox_ops;
> +       mbox->controller.txdone_irq =3D true;
> +
> +       ret =3D devm_mbox_controller_register(mbox->dev, &mbox->controlle=
r);
> +       if (ret) {
> +           dev_err(&pdev->dev, "Could not register mailbox controller\n"=
);
> +           return ret;
> +       }
> +
> +       return ret;
> +   }
> +
> +   static const struct of_device_id dummy_mbox_match[] =3D {
> +       { .compatible =3D "dummy,dummy-mailbox" },
> +       { },
> +   };
> +
> +   MODULE_DEVICE_TABLE(of, dummy_mbox_match);
> +
> +   static struct platform_driver dummy_mbox_driver =3D {
> +       .probe =3D dummy_mbox_probe,
> +       .driver =3D {
> +           .name =3D DRIVER_NAME,
> +           .of_match_table =3D dummy_mbox_match,
> +       },
> +   };
> +
> +   module_platform_driver(dummy_mbox_driver);
> +   MODULE_LICENSE("GPL v2");
> +   MODULE_DESCRIPTION("Dummy mailbox controller driver");
> +
> +In the above code, a couple of things are done:
> +a. The controller is registered in the probe along with callbacks, which=
 in
> +   this case are the bare minimum: ``startup``, ``shutdown``, and
> +   ``send_data``.
> +b. IRQ is registered to get notifications from the remote processor.
> +c. In the IRQ handler, registers are read to copy data, and
> +   ``mbox_chan_received_data`` is called to hand over the data to the cl=
ient.
> +d. ``mbox_chan_txdone`` is called to let the framework know that this da=
ta
> +   is the last data and no more data is to be expected for the current t=
ransfer.
> +
> --
> 2.39.3 (Apple Git-146)
>

