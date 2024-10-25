Return-Path: <linux-kernel+bounces-380962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBB9AF84A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BCBB21A88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF31189B9F;
	Fri, 25 Oct 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EliMAYPt"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E175588B;
	Fri, 25 Oct 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827527; cv=none; b=rTfv28puX/KTLONXlWO5gIR4EhU/mET2K6E6RoP8mEhju2n9fA3xLAfG8jNuvudCk9FjGBXR5gsIoTpmdGQu7vXKI/SlZMGrWbMtSwomuTNZx5yVNlyeCR1IenbomzMMzx75ObUhFjdwZlfpj6So8dkdWSfPj58HfW0BY9ADPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827527; c=relaxed/simple;
	bh=U62h+aQPSzgCmelnrxjUJOHqVTGP2r15FXtOrjWA2aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFLUf8sf3OWdsyKrYt7gNpLvYLRS29lxzGZLjVXHGl1RWybF0/KGHmafUh/ajINuCutDxPZ3IxKL1SzQ3apcvaclp9CM3Hj0BlC0mprxBFu/suu6SOVGknOSFSL0GFNM/rf4z7hKko63Us90iRZlhiiR8ypSF7DzgqmdTiQPk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EliMAYPt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so1150083a12.3;
        Thu, 24 Oct 2024 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827522; x=1730432322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmegcaCftsw7vXEu6Y2ynJafhxu26PY8JQ4z9zD9M6A=;
        b=EliMAYPtDpjJdgZiUPQYxnyZgqwYX+pmjqxD5blE2rCEzRdtkmQc+PntwJ4LZUNGeR
         phJRZyj5MgSORQa4x9FlvWGijFVsSxyhqMGZchor6I6ZKpEQOzqp3aeTLo//KWzew9V7
         HgyEC48BZLNN8BRiKRzRO5fshQRK0dybg39XLY/9ypJsKEosiTOtMVLMBPtd0CaGkYZt
         ayKd8HC+x6WsnfKwABCvnilL3bqzx0hyh+b3QaY+GxnQpi+e8H1um4Q8ROWTYwoVUX1c
         Sjg9yZRxft3ZqXIDaqLkPupd/g0Y68EI+bLUjOu1RvcqaPXmT1a5OZa0sWvXzt98Zwtq
         4fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827522; x=1730432322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmegcaCftsw7vXEu6Y2ynJafhxu26PY8JQ4z9zD9M6A=;
        b=Jk2z8rKd/zrzVt6XdfFVWL5DQOpPyYBU+BuPkS/VoNuhxOWTu7Qt0i0gVbWuU8lpYO
         xf9zeAsDIrBS9zrbi3l89nFP3XvKlcQ7KdrQeyKzinfH3lFOqgL6ObXtticaNLpFxiZf
         gAkdFSNA2Bai/ABhmKXeFwcVMynA4OQ85lojc2KuFhDvFzNCNijW0eGwRoLrOB4oZx2l
         zpgw51IQWoG2wuUhBXdLNviiTyju3aJU3jLsptiWEzYzhHGprI3LjiBsJ3k11bIXeEQ1
         ZCmmiPV+UbDUV9dLhVosmSKpD2zeFKAABhK0a+cpwZj3yB1Xk2UfAy9UbjlWe3vVVYLv
         NqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9wzPOgPjsXEiMu7mCDb1Kj/9xPfxDlGQCB/zYy9rMruq8gOpsh0hXYMCvQ/mu+4GXnGsx1GSNf78xUI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+nPVMCTIGraojEO5viBFPXJ7eW4+x5C07Kn+wFs2UOiK4jX7
	I0uqsmgJ48SDYyPBhlwfCWOS9OBRODyPVMLYftZHX2MuJ6r0LpiLkMqCcQ==
X-Google-Smtp-Source: AGHT+IHXzzu2fKQmXKw7VjVRNY01GMHi3CRHp4MUan4TMZUEkzu45SIwKuFXJ1cdMkF8wBvlsP3I8Q==
X-Received: by 2002:a05:6a21:6711:b0:1d9:275b:4eed with SMTP id adf61e73a8af0-1d978bc31ddmr10870374637.42.1729827521978;
        Thu, 24 Oct 2024 20:38:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a24199sm178768b3a.178.2024.10.24.20.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:38:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CD3D44433471; Fri, 25 Oct 2024 10:38:37 +0700 (WIB)
Date: Fri, 25 Oct 2024 10:38:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>, jassisinghbrar@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
Message-ID: <ZxsSvbXXiwNAHCWX@archie.me>
References: <20241019195534.79603-1-yesanishhere@gmail.com>
 <20241019195534.79603-2-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9ovl80ZU3TO/MtmI"
Content-Disposition: inline
In-Reply-To: <20241019195534.79603-2-yesanishhere@gmail.com>


--9ovl80ZU3TO/MtmI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:55:34PM -0700, anish kumar wrote:
> 1. added client documentation
> 2. added controller documentation.
> 3. added framework documentation

One doc topic on each patch, please.

>=20
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
>=20
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
> +   - **Function**: `mbox_send_message(struct mbox_chan *chan, void *msg)`
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

These functions should've been documented as kernel-doc comments, though.

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
> +       dc_async->cl.knows_txdone =3D false; /* depending upon protocol */
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
=2E...
> +:  client driver      client_a            client_b                      =
   :
> +........................................................................=
=2E...
> +                            ^-------------------^
> +                                    |
> +                                    |
> +........................................................................=
=2E...
> +:  controller framework          mailbox                                =
   :
> +....................................|...................................=
=2E...
> +                                    |
> +                                    |
> +........................................................................=
=2E...
> +:  controller driver          device specific                           =
   :
> +....................................|...................................=
=2E...
> +                                    |
> +                                    |
> +kernel                              |
> +........................................................................=
=2E...
> +hardware                            |
> +                                    |
> +                                    |
> +........................................................................=
=2E...
> +:                             remote processor                          =
   :
> +........................................................................=
=2E...

htmldocs build errors out:

Documentation/driver-api/mailbox/core.rst:57: WARNING: Block quote ends wit=
hout a blank line; unexpected unindent.
Documentation/driver-api/mailbox/core.rst:57: CRITICAL: Missing matching un=
derline for section title overline.

=2E........................................................................=
=2E..
:  controller framework          mailbox                                   :
=2E...................................|....................................=
=2E..

reST markup error:
Documentation/driver-api/mailbox/core.rst:57: (SEVERE/4) Missing matching u=
nderline for section title overline.

=2E........................................................................=
=2E..
:  controller framework          mailbox                                   :
=2E...................................|....................................=
=2E..

I have to fix up the design diagram and wrap it:

---- >8 ----
diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentation/driv=
er-api/mailbox/core.rst
index d1220086da679f..8d56d81007c11c 100644
--- a/Documentation/driver-api/mailbox/core.rst
+++ b/Documentation/driver-api/mailbox/core.rst
@@ -47,31 +47,32 @@ the mailbox client.
=20
 Mailbox Client: This component handles the sending and receiving of messag=
es.
=20
+::
=20
-..........................................................................=
=2E.
-:  client driver      client_a            client_b                        =
 :
-..........................................................................=
=2E.
-                            ^-------------------^
-                                    |
-                                    |
-..........................................................................=
=2E.
-:  controller framework          mailbox                                  =
 :
-....................................|.....................................=
=2E.
-                                    |
-                                    |
-..........................................................................=
=2E.
-:  controller driver          device specific                             =
 :
-....................................|.....................................=
=2E.
-                                    |
-                                    |
-kernel                              |
-..........................................................................=
=2E.
-hardware                            |
-                                    |
-                                    |
-..........................................................................=
=2E.
-:                             remote processor                            =
 :
-..........................................................................=
=2E.
+  +-----------------------------------------------------------------------=
----+
+  |  client driver      client_a            client_b                      =
    |
+  +-----------------------------------------------------------------------=
----+
+                              ^-------------------^
+                                      |
+                                      |
+  +-----------------------------------------------------------------------=
---+
+  |  controller framework          mailbox                                =
   |
+  +-----------------------------------|-----------------------------------=
---+
+                                      |
+                                      |
+  +-----------------------------------------------------------------------=
---+
+  |  controller driver          device specific                           =
   |
+  +-----------------------------------|-----------------------------------=
---+
+                                      |
+                                      |
+  kernel                              |
+  ------------------------------------------------------------------------=
----
+  hardware                            |
+                                      |
+                                      |
+  +-----------------------------------------------------------------------=
---+
+  |                             remote processor                          =
   |
+  +-----------------------------------------------------------------------=
---+
=20
=20
 In the context of a mailbox framework, a channel refers to a dedicated

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

Shouldn't these structs be documented as kernel-doc comments? tl;dr:
see Documentation/doc-guide/kernel-doc.html

> +
> +controller framework APIs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +``struct `mbox_controller` Initialization
> +-----------------------------------------

Properly double-backquote the struct name to format it as inline code:

---- >8 ----
diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentation/driv=
er-api/mailbox/core.rst
index 239538f497e41a..d83456164464aa 100644
--- a/Documentation/driver-api/mailbox/core.rst
+++ b/Documentation/driver-api/mailbox/core.rst
@@ -117,7 +117,7 @@ Data Structures
 controller framework APIs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-``struct `mbox_controller` Initialization
+``struct mbox_controller`` Initialization
 -----------------------------------------
=20
 Just like any other kernel framework, the whole mailbox controller registr=
ation

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
> +                          the TX status, but no interrupt is raised. This
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
> +  it returns a pointer to the channel. If the request fails (e.g., if the
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

Shouldn't these functions also be documented as kernel-doc comments?

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

Match up section underline length by its title:

---- >8 ----
diff --git a/Documentation/driver-api/mailbox/index.rst b/Documentation/dri=
ver-api/mailbox/index.rst
index e254a8fdb66ac7..02d7d5e8660999 100644
--- a/Documentation/driver-api/mailbox/index.rst
+++ b/Documentation/driver-api/mailbox/index.rst
@@ -1,6 +1,6 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Mailbox documentation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Mailbox documentation provides documents for various aspects of mailbox
 framework.
@@ -17,7 +17,7 @@ driver writers.
    core
=20
 mailbox controller driver documentation
-------------------------------
+---------------------------------------
=20
 This book is a guide to device driver writers on how to register
 mailbox controller to the mailbox framework.
@@ -28,7 +28,7 @@ mailbox controller to the mailbox framework.
    writing_mailbox_controller_drivers
=20
 mailbox client driver documentation
-------------------------------
+-----------------------------------
=20
 This book is a guide to mailbox client driver writers.
=20

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

Fix up also the reference link on parent toctree:

---- >8 ----
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/=
index.rst
index 7f83e05769b4a4..b4d78b92fd921a 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -102,7 +102,7 @@ Subsystem-specific APIs
    ipmb
    ipmi
    libata
-   mailbox
+   mailbox/index
    md/index
    media/index
    mei/index

> diff --git a/Documentation/driver-api/mailbox/writing_mailbox_controller_=
drivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_controller_d=
rivers.rst
> new file mode 100644
> index 000000000000..2a82645c1357
> --- /dev/null
> +++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers=
=2Erst
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
> +a. It supports only a single channel, i.e., only the remote processor can
> +   send interrupts.
> +b. Data transfer is over the registers associated with mailbox hardware.
> +c. Mailbox hardware is configured to receive interrupts.
> +d. When the remote processor is ready to send data, it triggers a mailbox
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

Sphinx warns out numerous indentation warnings on the lists, so I have to
fix them up:

---- >8 ----
diff --git a/Documentation/driver-api/mailbox/client.rst b/Documentation/dr=
iver-api/mailbox/client.rst
index 9088f83734230d..17dafaca056777 100644
--- a/Documentation/driver-api/mailbox/client.rst
+++ b/Documentation/driver-api/mailbox/client.rst
@@ -31,6 +31,7 @@ The mailbox structure is defined as follows:
 Key Functions
 -------------
 1. Requesting a Mailbox Channel
+
    - **Function**: `mbox_request_channel(struct mbox_client *client,
      unsigned int channel)`
    - **Description**: Requests a mailbox channel for sending messages.
@@ -41,15 +42,19 @@ Key Functions
      code on failure.
=20
 2. Sending a Message
+
    - **Function**: `mbox_send_message(struct mbox_chan *chan, void *msg)`
    - **Description**: Sends a message through the mailbox channel.
    - **Parameters**:
+
      - `chan`: The mailbox channel used for communication.
      - `msg`: Pointer to the message to be sent (usually NULL for dummy
        messages).
+
    - **Returns**: 0 on success, or a negative error code on failure.
=20
 3. Transmitting Completion
+
    - **Function**: `mbox_client_txdone(struct mbox_chan *chan, unsigned int
      msg_id)`
    - **Description**: Notifies the mailbox framework that message
diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentation/driv=
er-api/mailbox/core.rst
index 8d56d81007c11c..239538f497e41a 100644
--- a/Documentation/driver-api/mailbox/core.rst
+++ b/Documentation/driver-api/mailbox/core.rst
@@ -85,16 +85,20 @@ Data Structures
 - **struct mbox_client**
   This structure represents a client that communicates over a mailbox
   channel. It holds information such as:
+
   - A pointer to the device associated with the client (`dev`).
   - Callback functions for handling message transmission events, including:
+
     - `rx_callback`: Called when a message is received.
     - `tx_done`: Called when a message transmission is acknowledged.
+
   - Flags that specify the client=E2=80=99s configuration, such as whether=
 it operates
     in blocking mode.
=20
 - **struct mbox_chan**
   This structure represents an individual mailbox channel. It maintains the
   state required for message queuing and transmission. Key members include:
+
   - `msg_data`: Array of messages queued for transmission.
   - `msg_count`: Number of messages currently queued.
   - `msg_free`: Index of the next free slot in the message queue.
@@ -104,6 +108,7 @@ Data Structures
 - **struct mbox_controller**
   This structure represents a mailbox controller that manages multiple
   channels. It includes:
+
   - A pointer to the device managing the mailbox.
   - Operations for sending and receiving messages, as well as initializing
     and shutting down the mailbox.
@@ -133,21 +138,20 @@ need to initialize a few fields in there:
 - ``num_chans``: Number of channels in the `chans` array.
=20
 - ``txdone_irq``: Indicates if the controller can report to the API
-  when the last transmitted data was read by the
-                          remote (e.g., if it has a TX ACK interrupt).
+  when the last transmitted data was read by the remote (e.g., if it has a
+  TX ACK interrupt).
=20
 All the below fields are not mandatory.
=20
 - ``txdone_poll``: Indicates if the controller can read but not report
-                          the TX done. For example, some register may show
-                          the TX status, but no interrupt is raised. This
-                          field is ignored if `txdone_irq` is set.
+  the TX done. For example, some register may show the TX status, but no
+  interrupt is raised. This field is ignored if `txdone_irq` is set.
=20
 - ``txpoll_period``: If `txdone_poll` is in effect, the API polls for
-                          the last TX status after this many milliseconds.
+  the last TX status after this many milliseconds.
=20
 - ``of_xlate``: Controller driver-specific mapping of channel via
-                          Device Tree (DT).
+  Device Tree (DT).
=20
=20
 Key Functions
diff --git a/Documentation/driver-api/mailbox/writing_mailbox_controller_dr=
ivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_controller_dri=
vers.rst
index 2a82645c13573e..853adf6918173d 100644
--- a/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.r=
st
+++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.r=
st
@@ -21,6 +21,7 @@ As a bare minimum, a mailbox controller driver needs to c=
all
=20
 A basic driver skeleton could look like this for a mailbox hardware that
 has the following characteristics:
+
 a. It supports only a single channel, i.e., only the remote processor can
    send interrupts.
 b. Data transfer is over the registers associated with mailbox hardware.
@@ -168,6 +169,7 @@ e. As part of interrupt handling by Linux, it copies da=
ta from the registers.
    MODULE_DESCRIPTION("Dummy mailbox controller driver");
=20
 In the above code, a couple of things are done:
+
 a. The controller is registered in the probe along with callbacks, which in
    this case are the bare minimum: ``startup``, ``shutdown``, and
    ``send_data``.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9ovl80ZU3TO/MtmI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxsSuQAKCRD2uYlJVVFO
owksAQD1IsSSbnj/rK+9kLJs97jITGWsQX+Ly0vTOq6MUz2MgQEArxf/6sy86UIz
ajdt6l+y3pYwhK+mk+HMjotgSm5/zQY=
=W0ld
-----END PGP SIGNATURE-----

--9ovl80ZU3TO/MtmI--

