Return-Path: <linux-kernel+bounces-373013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B19A5099
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F381C21A87
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB751917C8;
	Sat, 19 Oct 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaJ0xJKW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4111191F9E;
	Sat, 19 Oct 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367745; cv=none; b=r7/RHAS+xUUaU+dM/R8Wj214O/Xw1ClWnim+TZ2XkQobzOOFL6JPFiQypv1Uhupvk9bqmPTCAE4rBuZqIkyMFNWDxnEqaDD9oI2glzJXKyVg6WkU8PpoAPtxxaLSr38Hk+S775le/lvLRSZJ5UXcE60vtYNMBMskG18TxxgUYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367745; c=relaxed/simple;
	bh=uiBFAqjROUtjGh2xZEARkeaWmLJ4kSsDu3kHMCeHHLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk2+7zksENDemEBekdLDkCvqDCQBHSXQt06rLAJGuQ1u5NipwfUr9EpUAYd9tP/x7eHwz5d9oSBQR5emB27SRmzdPCvZx/NIfLGKOOI2kJDjudjLxQBTG7KnQVzE+ZredJG79I8tg5kA+RAWC7ymBOocDuygd5BxkHdc13rT758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaJ0xJKW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso2203016a12.0;
        Sat, 19 Oct 2024 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729367742; x=1729972542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KZ+tDk9SPbp20AOjR9K0jN6I3eHxUfa91EcEMbegwA=;
        b=GaJ0xJKWI7gaBU213UtRheA7OJJsasV0+SF8XPRGEIg1JSeWlYtK7tIZP4z04x1wc9
         qAHW9Th4oXLY0BHH6w+p+EMeZomst739EvGjXAa0hUeCEpbTPWwAkCkPXb20nHUvITbO
         b84FLSEUlo2tNP5rwbrYTfYE4caJPTnXPxxKSlKTPshdQDsc0V7u/Xf1oaf5dk+tuYJz
         jej0R4KT2Nc9xZJnTo5/96uvHYYmiTSdXx5gy6KN8FDH9F0xttQOm7exRf81jiEueOM5
         rbco0bc9zPjxoCKcri7+B8vs7KxGrLcsVRkw7Q9Qu6uDIad2SOW86ZOlVSmO1uhVxJLj
         GUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729367742; x=1729972542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KZ+tDk9SPbp20AOjR9K0jN6I3eHxUfa91EcEMbegwA=;
        b=f+NVJXrTM8/b2WSHZL48q5AuLM5UnpIbgmDUbQzVF8nL4y6TNTalfhOgbgo1Ef9M2T
         LvB3a+UybrDgX0OCLnsnAxn4HJlGlkc46JTpQvTWJLH1DKtIiXN/PDJs5fUMLxhsI7Y8
         xzZmPMJ6TaUR0o7PGHNnNYzNIbqicEWntTy++YMfqoH8LS/7guj9wIZzdm0ffPTHmKct
         FQ3lTymvk+0pTXG94Mrn7AViHPMvix4JwpaDoQP1GRXHQkAgQy0iUnva2GT/A1M7Q4B3
         jbrBP/fKUJhVZkqckfS+k8DmRKk04Koh6YKJYjxHSF+mE2VvAAU+xnHqoBUo1bVeLA3+
         cSOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCS4dxLoV3GBsdgnzB5pxHsNFzb/emzEXMEhGlrD5NO/e8XMz+rcLiOxaOJAMO6qDM4AK3zStgsoYhAss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrVK6//aj39hgbCmnL2MwIIOz7h+ChH+3Ql/iZ74hmEAG0ejk
	MgpPna6zEIkL1FAROA+7gDuxcDdI2LDcitnSlruXYProaxL1ePhF
X-Google-Smtp-Source: AGHT+IHzO19PRgK7KFSLdI/PuKpgk7a6Ouc+OzVBeXPU+J8tBTxOGvh2DMTnwgUPLqTJRUi+pbnjfQ==
X-Received: by 2002:a05:6a21:6f01:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1d92ca2a79fmr8889491637.10.1729367741736;
        Sat, 19 Oct 2024 12:55:41 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:183b:c6cf:8f19:74f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1dc5esm125133a12.25.2024.10.19.12.55.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Oct 2024 12:55:41 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: jassisinghbrar@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 2/2] mailbox: Documentation: add the latest documentation
Date: Sat, 19 Oct 2024 12:55:34 -0700
Message-Id: <20241019195534.79603-2-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241019195534.79603-1-yesanishhere@gmail.com>
References: <20241019195534.79603-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

1. added client documentation
2. added controller documentation.
3. added framework documentation

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/mailbox/client.rst   | 192 ++++++++++++++++++
 Documentation/driver-api/mailbox/core.rst     | 182 +++++++++++++++++
 Documentation/driver-api/mailbox/index.rst    |  45 ++++
 .../writing_mailbox_controller_drivers.rst    | 179 ++++++++++++++++
 4 files changed, 598 insertions(+)
 create mode 100644 Documentation/driver-api/mailbox/client.rst
 create mode 100644 Documentation/driver-api/mailbox/core.rst
 create mode 100644 Documentation/driver-api/mailbox/index.rst
 create mode 100644 Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.rst

diff --git a/Documentation/driver-api/mailbox/client.rst b/Documentation/driver-api/mailbox/client.rst
new file mode 100644
index 000000000000..9088f8373423
--- /dev/null
+++ b/Documentation/driver-api/mailbox/client.rst
@@ -0,0 +1,192 @@
+Mailbox Client Documentation
+============================
+
+Overview
+--------
+The mailbox client driver is responsible for sending and receiving messages
+to and from a remote processor. It uses mailbox APIs provided by the
+mailbox framework.
+
+Mailbox Structure
+-----------------
+The mailbox structure is defined as follows:
+
+.. code-block:: c
+
+   struct mbox_client {
+       //device associated with the mailbox
+       struct device *dev;
+       // callback for transmission completion
+       void (*tx_done)(struct mbox_client *client);
+       // callback to prepare for sending a message
+       void (*tx_prepare)(struct mbox_client *client);
+       // callback for received messages
+       void (*rx_callback)(struct mbox_client *client, void *data);
+       // flag to indicate if transmission should block
+       bool tx_block;
+       // indicates if the client knows when transmission is done
+       bool knows_txdone;
+   };
+
+Key Functions
+-------------
+1. Requesting a Mailbox Channel
+   - **Function**: `mbox_request_channel(struct mbox_client *client,
+     unsigned int channel)`
+   - **Description**: Requests a mailbox channel for sending messages.
+   - **Parameters**:
+     - `client`: Pointer to the mailbox client structure.
+     - `channel`: The specific mailbox channel to request.
+   - **Returns**: A pointer to the mailbox channel on success, or an error
+     code on failure.
+
+2. Sending a Message
+   - **Function**: `mbox_send_message(struct mbox_chan *chan, void *msg)`
+   - **Description**: Sends a message through the mailbox channel.
+   - **Parameters**:
+     - `chan`: The mailbox channel used for communication.
+     - `msg`: Pointer to the message to be sent (usually NULL for dummy
+       messages).
+   - **Returns**: 0 on success, or a negative error code on failure.
+
+3. Transmitting Completion
+   - **Function**: `mbox_client_txdone(struct mbox_chan *chan, unsigned int
+     msg_id)`
+   - **Description**: Notifies the mailbox framework that message
+     transmission is complete.
+   - **Parameters**:
+     - `chan`: The mailbox channel associated with the message.
+     - `msg_id`: The identifier of the message that was transmitted.
+
+Usage Example
+-------------
+In a typical mailbox client driver, the following steps are typically
+performed:
+
+1. Initialize the Mailbox Client:
+
+   .. code-block:: c
+
+      struct mbox_client my_mbox_client = {
+          .dev = &my_device,
+          .tx_done = my_tx_done_callback,
+          .rx_callback = my_rx_callback,
+          .tx_block = false,
+          .knows_txdone = true,
+      };
+
+2. Request a Mailbox Channel:
+
+   .. code-block:: c
+
+      mbox_chan = mbox_request_channel(&my_mbox_client, 0);
+      if (IS_ERR(mbox_chan)) {
+          // Handle error
+      }
+
+3. Send a Message:
+
+   .. code-block:: c
+
+      int ret = mbox_send_message(mbox_chan, NULL); // Sending a dummy message
+      if (ret < 0) {
+          // Handle error
+      }
+
+4. Complete Transmission:
+
+   .. code-block:: c
+
+      mbox_client_txdone(mbox_chan, 0);
+
+Interrupt Handling
+------------------
+The mailbox interface can trigger interrupts upon message receipt. Handlers
+should be implemented in the `rx_callback` function defined in the mailbox
+client structure to process incoming messages.
+
+Example Mailbox Client Driver
+-----------------------------
+.. code-block:: c
+
+   struct demo_client {
+       struct mbox_client cl;
+       struct mbox_chan *mbox;
+       struct completion c;
+       bool async;
+       /* ... */
+   };
+
+   /*
+   * This is the handler for data received from remote. The behaviour is purely
+   * dependent upon the protocol. This is just an example.
+   */
+   static void message_from_remote(struct mbox_client *cl, void *mssg)
+   {
+       struct demo_client *dc = container_of(cl, struct demo_client, cl);
+       if (dc->async) {
+           if (is_an_ack(mssg)) {
+               /* An ACK to our last sample sent */
+               return; /* Or do something else here */
+           } else { /* A new message from remote */
+               queue_req(mssg);
+           }
+       } else {
+           /* Remote f/w sends only ACK packets on this channel */
+           return;
+       }
+   }
+
+   static void sample_sent(struct mbox_client *cl, void *mssg, int r)
+   {
+       struct demo_client *dc = container_of(cl, struct demo_client, cl);
+       complete(&dc->c);
+   }
+
+   static void client_demo(struct platform_device *pdev)
+   {
+       struct demo_client *dc_sync, *dc_async;
+       /* The controller already knows async_pkt and sync_pkt */
+       struct async_pkt ap;
+       struct sync_pkt sp;
+
+       dc_sync = kzalloc(sizeof(*dc_sync), GFP_KERNEL);
+       dc_async = kzalloc(sizeof(*dc_async), GFP_KERNEL);
+
+       /* Populate non-blocking mode client */
+       dc_async->cl.dev = &pdev->dev;
+       dc_async->cl.rx_callback = message_from_remote;
+       dc_async->cl.tx_done = sample_sent;
+       dc_async->cl.tx_block = false;
+       dc_async->cl.tx_tout = 0; /* doesn't matter here */
+       dc_async->cl.knows_txdone = false; /* depending upon protocol */
+       dc_async->async = true;
+       init_completion(&dc_async->c);
+
+       /* Populate blocking mode client */
+       dc_sync->cl.dev = &pdev->dev;
+       dc_sync->cl.rx_callback = message_from_remote;
+       dc_sync->cl.tx_done = NULL; /* operate in blocking mode */
+       dc_sync->cl.tx_block = true;
+       dc_sync->cl.tx_tout = 500; /* by half a second */
+       dc_sync->cl.knows_txdone = false; /* depending upon protocol */
+       dc_sync->async = false;
+
+       /* ASync mailbox is listed second in 'mboxes' property */
+       dc_async->mbox = mbox_request_channel(&dc_async->cl, 1);
+       /* Populate data packet */
+       /* ap.xxx = 123; etc */
+       /* Send async message to remote */
+       mbox_send_message(dc_async->mbox, &ap);
+
+       /* Sync mailbox is listed first in 'mboxes' property */
+       dc_sync->mbox = mbox_request_channel(&dc_sync->cl, 0);
+       /* Populate data packet */
+       /* sp.abc = 123; etc */
+       /* Send message to remote in blocking mode */
+       mbox_send_message(dc_sync->mbox, &sp);
+       /* At this point 'sp' has been sent */
+
+       /* Now wait for async chan to be done */
+       wait_for_completion(&dc_async->c);
+   }
diff --git a/Documentation/driver-api/mailbox/core.rst b/Documentation/driver-api/mailbox/core.rst
new file mode 100644
index 000000000000..d1220086da67
--- /dev/null
+++ b/Documentation/driver-api/mailbox/core.rst
@@ -0,0 +1,182 @@
+=====================
+mailbox documentation
+=====================
+
+Hardware Introduction
+=====================
+
+Mailbox hardware is a specialized component found in multi-core
+processors and embedded systems that facilitates inter-processor
+communication (IPC) or communication between different hardware
+components. It provides a structured mechanism for sending and
+receiving messages, allowing various processors or devices to
+exchange data efficiently. Here's an overview of its key
+characteristics and functions:
+
+Key Characteristics of Mailbox Hardware
+Interrupt Handling: Many mailbox implementations support
+interrupt-driven communication. This allows a receiving processor
+to be alerted when a new message arrives, facilitating immediate
+processing without polling the mailbox constantly.
+
+Hardware Registers: Mailbox hardware often includes registers for
+configuration and status monitoring. These registers can be used
+to control the mailbox's behavior, check for available messages,
+or acknowledge message receipt.
+
+Support for Multiple Protocols: Mailboxes can support various
+communication protocols, enabling interoperability between different
+hardware components and simplifying the integration of diverse systems.
+
+Synchronous and Asynchronous Modes: Mailbox hardware can operate in
+both synchronous and asynchronous modes. In synchronous mode, the
+sender may wait for the receiver to acknowledge receipt before
+proceeding, while in asynchronous mode, the sender can continue
+executing other tasks immediately after sending the message.
+
+
+Mailbox framework design
+========================
+
+The mailbox facilitates interprocessor communication by allowing processors to
+exchange messages or signals. The mailbox framework consists of:
+
+Mailbox Controller: This is platform-specific and is responsible for configuring
+and managing interrupts from the remote processor. It offers a generic API for
+the mailbox client.
+
+Mailbox Client: This component handles the sending and receiving of messages.
+
+
+............................................................................
+:  client driver      client_a            client_b                         :
+............................................................................
+                            ^-------------------^
+                                    |
+                                    |
+............................................................................
+:  controller framework          mailbox                                   :
+....................................|.......................................
+                                    |
+                                    |
+............................................................................
+:  controller driver          device specific                              :
+....................................|.......................................
+                                    |
+                                    |
+kernel                              |
+............................................................................
+hardware                            |
+                                    |
+                                    |
+............................................................................
+:                             remote processor                             :
+............................................................................
+
+
+In the context of a mailbox framework, a channel refers to a dedicated
+communication pathway between two or more processors or components. By using
+channels, the framework abstracts the complexity of interprocessor communication.
+
+Data Structures
+================
+
+- **struct mbox_client**
+  This structure represents a client that communicates over a mailbox
+  channel. It holds information such as:
+  - A pointer to the device associated with the client (`dev`).
+  - Callback functions for handling message transmission events, including:
+    - `rx_callback`: Called when a message is received.
+    - `tx_done`: Called when a message transmission is acknowledged.
+  - Flags that specify the client’s configuration, such as whether it operates
+    in blocking mode.
+
+- **struct mbox_chan**
+  This structure represents an individual mailbox channel. It maintains the
+  state required for message queuing and transmission. Key members include:
+  - `msg_data`: Array of messages queued for transmission.
+  - `msg_count`: Number of messages currently queued.
+  - `msg_free`: Index of the next free slot in the message queue.
+  - `active_req`: Pointer to the currently active message being transmitted.
+  - Synchronization primitives to manage access from multiple contexts.
+
+- **struct mbox_controller**
+  This structure represents a mailbox controller that manages multiple
+  channels. It includes:
+  - A pointer to the device managing the mailbox.
+  - Operations for sending and receiving messages, as well as initializing
+    and shutting down the mailbox.
+  - A list of associated channels and the total number of channels available.
+
+controller framework APIs
+=========================
+
+``struct `mbox_controller` Initialization
+-----------------------------------------
+
+Just like any other kernel framework, the whole mailbox controller registration
+relies on the driver filling a structure and registering against the
+framework. In our case, that structure is mbox_controller.
+
+The first thing you need to do in your driver is to allocate this
+structure. Any of the usual memory allocators will do, but you'll also
+need to initialize a few fields in there:
+
+- ``dev``: should hold the pointer to the ``struct device`` associated
+  to your current driver instance.
+
+- ``ops``: Operators that work on each communication channel.
+
+- ``chans``: Array of channels.
+
+- ``num_chans``: Number of channels in the `chans` array.
+
+- ``txdone_irq``: Indicates if the controller can report to the API
+  when the last transmitted data was read by the
+                          remote (e.g., if it has a TX ACK interrupt).
+
+All the below fields are not mandatory.
+
+- ``txdone_poll``: Indicates if the controller can read but not report
+                          the TX done. For example, some register may show
+                          the TX status, but no interrupt is raised. This
+                          field is ignored if `txdone_irq` is set.
+
+- ``txpoll_period``: If `txdone_poll` is in effect, the API polls for
+                          the last TX status after this many milliseconds.
+
+- ``of_xlate``: Controller driver-specific mapping of channel via
+                          Device Tree (DT).
+
+
+Key Functions
+-------------
+
+- **int devm_mbox_controller_register(struct mbox_controller *mbox)**
+  This function registers a mailbox controller with the kernel. It makes the
+  channels associated with the controller available for client requests. The
+  function performs sanity checks on the controller structure to ensure all
+  necessary fields are populated.
+
+- **struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)**
+  This function requests a mailbox channel for a specified client, identified
+  by an index. It searches for the appropriate mailbox channel, and if found,
+  it returns a pointer to the channel. If the request fails (e.g., if the
+  index is invalid), it returns an error pointer.
+
+- **void mbox_free_channel(struct mbox_chan *chan)**
+  This function releases a mailbox channel that was previously allocated for a
+  client. It ensures that the channel can be reused by other clients. If any
+  messages are still in the queue, they are aborted, and no callbacks are made.
+
+- **int mbox_send_message(struct mbox_chan *chan, void *mssg)**
+  This function is used by clients to send a message through the specified
+  mailbox channel. The function can operate in either blocking or non-blocking
+  mode, depending on the client’s configuration. It will queue the message for
+  transmission and notify the client once the message is acknowledged.
+
+- **void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)**
+  This function is called by the controller driver to notify the mailbox
+  framework that a message has been received on the specified channel. The
+  received message is then passed to the appropriate client's `rx_callback`
+  function for processing.
diff --git a/Documentation/driver-api/mailbox/index.rst b/Documentation/driver-api/mailbox/index.rst
new file mode 100644
index 000000000000..e254a8fdb66a
--- /dev/null
+++ b/Documentation/driver-api/mailbox/index.rst
@@ -0,0 +1,45 @@
+=======================
+Mailbox documentation
+=======================
+
+Mailbox documentation provides documents for various aspects of mailbox
+framework.
+
+Mailbox development documentation
+---------------------------------
+
+This book helps with mailbox internal APIs and guide for mailbox device
+driver writers.
+
+.. toctree::
+   :maxdepth: 1
+
+   core
+
+mailbox controller driver documentation
+------------------------------
+
+This book is a guide to device driver writers on how to register
+mailbox controller to the mailbox framework.
+
+.. toctree::
+   :maxdepth: 1
+
+   writing_mailbox_controller_drivers
+
+mailbox client driver documentation
+------------------------------
+
+This book is a guide to mailbox client driver writers.
+
+.. toctree::
+   :maxdepth: 1
+
+   client
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.rst b/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.rst
new file mode 100644
index 000000000000..2a82645c1357
--- /dev/null
+++ b/Documentation/driver-api/mailbox/writing_mailbox_controller_drivers.rst
@@ -0,0 +1,179 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _writing_mailbox_controller_drivers:
+
+==================================
+Writing Mailbox Controller Drivers
+==================================
+
+Introduction
+============
+
+This document serves as a basic guideline for driver programmers that need
+to hack a new mailbox controller driver or understand the essentials of
+the existing ones.
+
+Driver Boilerplate
+==================
+
+As a bare minimum, a mailbox controller driver needs to call
+``mbox_controller_register`` function to register with the framework.
+
+A basic driver skeleton could look like this for a mailbox hardware that
+has the following characteristics:
+a. It supports only a single channel, i.e., only the remote processor can
+   send interrupts.
+b. Data transfer is over the registers associated with mailbox hardware.
+c. Mailbox hardware is configured to receive interrupts.
+d. When the remote processor is ready to send data, it triggers a mailbox
+   interrupt.
+e. As part of interrupt handling by Linux, it copies data from the registers.
+
+.. code-block:: c
+
+   #include <linux/device.h>
+   #include <linux/interrupt.h>
+   #include <linux/io.h>
+   #include <linux/kernel.h>
+   #include <linux/mailbox_controller.h>
+   #include <linux/module.h>
+   #include <linux/of.h>
+   #include <linux/platform_device.h>
+   #define DRIVER_NAME "dummy_controller"
+
+   struct dummy_mbox {
+       struct device *dev;
+       struct mbox_controller controller;
+       int irq;
+   };
+
+   static void dummy_mbox_receive(struct mbox_chan *chan)
+   {
+       struct dummy_mbox *mbox = chan->con_priv;
+       int val;
+
+       // Data copied from registers
+       val = read_register();
+       mbox_chan_received_data(chan, &val);
+   }
+
+   static irqreturn_t dummy_mbox_irq_handler(int irq, void *data)
+   {
+       struct mbox_chan *chan = data;
+       struct dummy_mbox *mbox = chan->con_priv;
+       u32 reg;
+
+       // Read registers to see if data is received
+       dummy_mbox_receive(chan);
+       mbox_chan_txdone(chan, 0);
+       return reg ? IRQ_HANDLED : IRQ_NONE;
+   }
+
+   static int dummy_mbox_send_data(struct mbox_chan *chan, void *data)
+   {
+       // Write data in registers to send it to the remote processor
+       return 0;
+   }
+
+   static int dummy_mbox_startup(struct mbox_chan *chan)
+   {
+       struct dummy_mbox *mbox = chan->con_priv;
+       u32 reg;
+       int ret;
+
+       ret = devm_request_irq(mbox->dev, mbox->irq, dummy_mbox_irq_handler, 0,
+               DRIVER_NAME, chan);
+       if (ret < 0) {
+           dev_err(mbox->dev, "Cannot request irq\n");
+           return ret;
+       }
+
+       /* Register write to enable IRQ generation */
+
+       return 0;
+   }
+
+   static void dummy_mbox_shutdown(struct mbox_chan *chan)
+   {
+       struct dummy_mbox *mbox = chan->con_priv;
+
+       /* Disable interrupt generation */
+       devm_free_irq(mbox->dev, mbox->irq, chan);
+   }
+
+   static const struct mbox_chan_ops dummy_mbox_ops = {
+       .send_data = dummy_mbox_send_data,
+       .startup = dummy_mbox_startup,
+       .shutdown = dummy_mbox_shutdown,
+   };
+
+   static int dummy_mbox_probe(struct platform_device *pdev)
+   {
+       struct dummy_mbox *mbox;
+       struct mbox_chan *chans;
+       int ret;
+
+       mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
+       if (!mbox)
+           return -ENOMEM;
+
+       /* Allocate one channel */
+       chans = devm_kzalloc(&pdev->dev, sizeof(*chans), GFP_KERNEL);
+       if (!chans)
+           return -ENOMEM;
+
+       mbox->base = devm_platform_ioremap_resource(pdev, 0);
+       if (IS_ERR(mbox->base))
+           return PTR_ERR(mbox->base);
+
+       mbox->irq = platform_get_irq(pdev, 0);
+       if (mbox->irq < 0)
+           return mbox->irq;
+
+       mbox->dev = &pdev->dev;
+
+       /* Hardware supports only one channel. */
+       mbox->controller.dev = mbox->dev;
+       mbox->controller.num_chans = 1;
+       mbox->controller.chans = chans;
+       mbox->controller.ops = &dummy_mbox_ops;
+       mbox->controller.txdone_irq = true;
+
+       ret = devm_mbox_controller_register(mbox->dev, &mbox->controller);
+       if (ret) {
+           dev_err(&pdev->dev, "Could not register mailbox controller\n");
+           return ret;
+       }
+
+       return ret;
+   }
+
+   static const struct of_device_id dummy_mbox_match[] = {
+       { .compatible = "dummy,dummy-mailbox" },
+       { },
+   };
+
+   MODULE_DEVICE_TABLE(of, dummy_mbox_match);
+
+   static struct platform_driver dummy_mbox_driver = {
+       .probe = dummy_mbox_probe,
+       .driver = {
+           .name = DRIVER_NAME,
+           .of_match_table = dummy_mbox_match,
+       },
+   };
+
+   module_platform_driver(dummy_mbox_driver);
+   MODULE_LICENSE("GPL v2");
+   MODULE_DESCRIPTION("Dummy mailbox controller driver");
+
+In the above code, a couple of things are done:
+a. The controller is registered in the probe along with callbacks, which in
+   this case are the bare minimum: ``startup``, ``shutdown``, and
+   ``send_data``.
+b. IRQ is registered to get notifications from the remote processor.
+c. In the IRQ handler, registers are read to copy data, and
+   ``mbox_chan_received_data`` is called to hand over the data to the client.
+d. ``mbox_chan_txdone`` is called to let the framework know that this data
+   is the last data and no more data is to be expected for the current transfer.
+
-- 
2.39.3 (Apple Git-146)


