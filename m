Return-Path: <linux-kernel+bounces-427109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC39DFCC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2D8281D08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BF1FA157;
	Mon,  2 Dec 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.wtf header.i=@kernel.wtf header.b="f4Bi1goL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGG+iTPl"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE11F9F71;
	Mon,  2 Dec 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130389; cv=none; b=ESG0ymjhexD1LFPNm76LQcWBwOgBPgpVZb/v+xytLCUxdvR7ZO0UYF/LAHA0XPXnCrs+0g9ayG33OtrMis8KWz4GmiYqjxIapYayj436T0gfi9tIKqjFk99RlPgU1eROntjIUd9xkLgo2Jj8bd+qvuVkVxpRwyKm9DoGqPZduEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130389; c=relaxed/simple;
	bh=jNavwIvnYu+B4Gy409cVV66ueXLAChACMI2wQzJMhjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/P9RtAsEcXPLfFBGvSD37euiX3P12qMfVsid6yfcU0gYCkB8Pg75C+NEvubtXGRpRDhXn5/ZuOWW6jq0gHCOmVIInEL5/TOfP5l7wrPPWerZ9aPHwnuDadaDHwvGNkrcynkxZZnF9PZiH+7RM1APxX94VaufQNnVXLEPHVAD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.wtf; spf=pass smtp.mailfrom=kernel.wtf; dkim=pass (2048-bit key) header.d=kernel.wtf header.i=@kernel.wtf header.b=f4Bi1goL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGG+iTPl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.wtf
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6DE12540147;
	Mon,  2 Dec 2024 04:06:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 04:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.wtf; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1733130384; x=1733216784; bh=RY
	0xzNXnrBP2/mo4uEMhnsNUaoaeElChhA+6CxJVcD4=; b=f4Bi1goLtmkAfZ8kvY
	x2a9pqEdQ/gPlroiOjtDqkG/8F1zwLukhbFDE2j4L2g7oQ/Yn5qiHiBssbyB/dYF
	LlfbAxjuZRC2xtWEJ4yGUXhr4w3ZmE+7uP+r31Nvb2KHbkx2JZWWCtHolqjArVX+
	rAj+q3WsIRznusgstxUdLzNIExXO624bgn971oN1uHdhev/vS9ek+Oeyc7z+E8u3
	ncIgc9maPldCfx3neDsvV5G9wZg42K73r2y61DukYsBROkmD4rEXfbkqKcUJOG+I
	khiTdBqwwGreMsb0lsj8mo019s3PRdgFNZQ1G96VYOij/4dkUTyQrwitRaVop60x
	dAbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733130384; x=1733216784; bh=RY0xzNXnrBP2/mo4uEMhnsNUaoae
	ElChhA+6CxJVcD4=; b=wGG+iTPlHqpn39MmlVxtfBWpWE5lblLfx48Hlx5eAaUw
	jdg0Nqid2sbPut1K482FbsMgz/NohBwlXK5bmDgGi1SE/P9e1yL7WaXWq1w+OhK5
	W55ISsXNQDm0gTAn07p8kyqJfVoqEwOklVGa8BkSpgEsvVYnVllop6EZXQV9cYSk
	do1blPMin1znXpgFSwppzdcBiPDex9989XNkdAWLhWvyUqEy+ZDgEUH1i3Q0/HS2
	QRcU1YaHIh7XSvH595SE/GdJQDEwaRO+W2Pz9HjE9aUfb1IsUrFxgD62+58pHjNa
	qRZevcUGaMkXJjPGBobQRxu5H6qkhQva5DIc1Wixrg==
X-ME-Sender: <xms:kHhNZ3raX0txsNzNv2WfFiScH53gUNgLumvS38gYZNuhJB0WLnNc1A>
    <xme:kHhNZxq-h7J32jAYUwjBG-Tl-LtgqWOF0z4x9j1lNnxmfUWu09WWNiF-vhAddzWa2
    NSti89XDcrMjJIzgaE>
X-ME-Received: <xmr:kHhNZ0Ol77slde3jQNYWMnTPofow0Rq4pKziFzgjYHAAjEqQNX8LlSb3aIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpeevvghnghhiiicuvegrnhcuoegtvghnghhiiieskhgvrhhnvghlrdifthhfqe
    enucggtffrrghtthgvrhhnpedukedvhfevvdetteefuedtheeuffdtvdetveeiheffffeh
    udejffetudelledutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegtvghnghhiiieskhgvrhhnvghlrdifthhfpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
    dprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptggvnhhgihiirdgtrghnsegtrghnohhnihgtrghlrdgtohhm
X-ME-Proxy: <xmx:kHhNZ677KgwRJNuIcaB1g2r5cN0kIfBiY2vvflHajrSHv7ZuKeU0QQ>
    <xmx:kHhNZ25BF_HuiErOsPCVNoDrned429CQ8Go082JRJLOBieGQ1-YwVA>
    <xmx:kHhNZyhM_sFv4GdGoiwY7EQTuR4q-IP3NKPrfHxA2RF0ExV5WRcLwA>
    <xmx:kHhNZ47uL2lduC7PDqghEHaX7_mqYnTQ3jm8-VY-iasOnAXJPVtnZw>
    <xmx:kHhNZx2Bz1WQdnY7YaPUSe0UDT4_5scFXBlgmYSRDrfQUtG__I7TkSj4>
Feedback-ID: iedb9463b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 04:06:23 -0500 (EST)
From: Cengiz Can <cengiz@kernel.wtf>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cengiz.can@canonical.com
Subject: [PATCH] Documentation: remove :kyb: tags
Date: Mon,  2 Dec 2024 09:05:02 +0000
Message-ID: <20241202090514.1716-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

:kyb: is an extra markup that we should avoid when we can.

It worsens the plain-text reading experience and adds very little value
to rendered views.

Remove all :kbd: tags from Documentation/*

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 Documentation/admin-guide/braille-console.rst |  4 +-
 Documentation/admin-guide/sysrq.rst           | 20 ++++----
 Documentation/dev-tools/kgdb.rst              | 50 +++++++++----------
 Documentation/process/email-clients.rst       |  8 +--
 Documentation/scheduler/sched-ext.rst         |  6 +--
 .../it_IT/process/email-clients.rst           |  8 +--
 .../sp_SP/process/email-clients.rst           |  8 +--
 .../translations/zh_CN/admin-guide/sysrq.rst  | 22 ++++----
 .../zh_CN/process/email-clients.rst           |  8 +--
 .../translations/zh_TW/admin-guide/sysrq.rst  | 22 ++++----
 .../zh_TW/process/email-clients.rst           |  8 +--
 11 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/Documentation/admin-guide/braille-console.rst b/Documentation/admin-guide/braille-console.rst
index 18e79337dc..153472e93c 100644
--- a/Documentation/admin-guide/braille-console.rst
+++ b/Documentation/admin-guide/braille-console.rst
@@ -21,8 +21,8 @@ override the baud rate to 115200, etc.
 By default, the braille device will just show the last kernel message (console
 mode).  To review previous messages, press the Insert key to switch to the VT
 review mode.  In review mode, the arrow keys permit to browse in the VT content,
-:kbd:`PAGE-UP`/:kbd:`PAGE-DOWN` keys go at the top/bottom of the screen, and
-the :kbd:`HOME` key goes back
+`PAGE-UP`/`PAGE-DOWN` keys go at the top/bottom of the screen, and
+the `HOME` key goes back
 to the cursor, hence providing very basic screen reviewing facility.
 
 Sound feedback can be obtained by adding the ``braille_console.sound=1`` kernel
diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index a85b3384d1..9c7aa817ad 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -49,26 +49,26 @@ How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 On x86
-	You press the key combo :kbd:`ALT-SysRq-<command key>`.
+	You press the key combo `ALT-SysRq-<command key>`.
 
 	.. note::
 	   Some
            keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
            also known as the 'Print Screen' key. Also some keyboards cannot
 	   handle so many keys being pressed at the same time, so you might
-	   have better luck with press :kbd:`Alt`, press :kbd:`SysRq`,
-	   release :kbd:`SysRq`, press :kbd:`<command key>`, release everything.
+	   have better luck with press `Alt`, press `SysRq`,
+	   release `SysRq`, press `<command key>`, release everything.
 
 On SPARC
-	You press :kbd:`ALT-STOP-<command key>`, I believe.
+	You press `ALT-STOP-<command key>`, I believe.
 
 On the serial console (PC style standard serial ports only)
         You send a ``BREAK``, then within 5 seconds a command key. Sending
         ``BREAK`` twice is interpreted as a normal BREAK.
 
 On PowerPC
-	Press :kbd:`ALT - Print Screen` (or :kbd:`F13`) - :kbd:`<command key>`.
-        :kbd:`Print Screen` (or :kbd:`F13`) - :kbd:`<command key>` may suffice.
+	Press `ALT - Print Screen` (or `F13`) - `<command key>`.
+        `Print Screen` (or `F13`) - `<command key>` may suffice.
 
 On other
 	If you know of the key combos for other architectures, please
@@ -88,7 +88,7 @@ On all
 
 		echo _reisub > /proc/sysrq-trigger
 
-The :kbd:`<command key>` is case sensitive.
+The `<command key>` is case sensitive.
 
 What are the 'command' keys?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -225,9 +225,9 @@ Sometimes SysRq seems to get 'stuck' after using it, what can I do?
 
 When this happens, try tapping shift, alt and control on both sides of the
 keyboard, and hitting an invalid sysrq sequence again. (i.e., something like
-:kbd:`alt-sysrq-z`).
+`alt-sysrq-z`).
 
-Switching to another virtual console (:kbd:`ALT+Fn`) and then back again
+Switching to another virtual console (`ALT+Fn`) and then back again
 should also help.
 
 I hit SysRq, but nothing seems to happen, what's wrong?
@@ -290,7 +290,7 @@ exception the header line from the sysrq command is passed to all console
 consumers as if the current loglevel was maximum.  If only the header
 is emitted it is almost certain that the kernel loglevel is too low.
 Should you require the output on the console channel then you will need
-to temporarily up the console loglevel using :kbd:`alt-sysrq-8` or::
+to temporarily up the console loglevel using `alt-sysrq-8` or::
 
     echo 8 > /proc/sysrq-trigger
 
diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index cb626a7a00..b29b0aac27 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -255,10 +255,10 @@ scenarios.
 .. note::
 
    Kgdboc does not support interrupting the target via the gdb remote
-   protocol. You must manually send a :kbd:`SysRq-G` unless you have a proxy
+   protocol. You must manually send a `SysRq-G` unless you have a proxy
    that splits console output to a terminal program. A console proxy has a
    separate TCP port for the debugger and a separate TCP port for the
-   "human" console. The proxy can take care of sending the :kbd:`SysRq-G`
+   "human" console. The proxy can take care of sending the `SysRq-G`
    for you.
 
 When using kgdboc with no debugger proxy, you can end up connecting the
@@ -267,9 +267,9 @@ have loaded kgdboc, a message should print on the console stating it is
 waiting for the debugger. In this case you disconnect your terminal
 program and then connect the debugger in its place. If you want to
 interrupt the target system and forcibly enter a debug session you have
-to issue a :kbd:`Sysrq` sequence and then type the letter :kbd:`g`. Then you
+to issue a `Sysrq` sequence and then type the letter `g`. Then you
 disconnect the terminal session and connect gdb. Your options if you
-don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
+don't like this are to hack gdb to send the `SysRq-G` for you as well as
 on the initial connect, or to use a debugger proxy that allows an
 unmodified gdb to do the debugging.
 
@@ -401,7 +401,7 @@ This is a quick example of how to use kdb.
 
 2. Enter the kernel debugger manually or by waiting for an oops or
    fault. There are several ways you can enter the kernel debugger
-   manually; all involve using the :kbd:`SysRq-G`, which means you must have
+   manually; all involve using the `SysRq-G`, which means you must have
    enabled ``CONFIG_MAGIC_SYSRQ=y`` in your kernel config.
 
    -  When logged in as root or with a super user session you can run::
@@ -410,16 +410,16 @@ This is a quick example of how to use kdb.
 
    -  Example using minicom 2.2
 
-      Press: :kbd:`CTRL-A` :kbd:`f` :kbd:`g`
+      Press: `CTRL-A` `f` `g`
 
    -  When you have telneted to a terminal server that supports sending
       a remote break
 
-      Press: :kbd:`CTRL-]`
+      Press: `CTRL-]`
 
       Type in: ``send break``
 
-      Press: :kbd:`Enter` :kbd:`g`
+      Press: `Enter` `g`
 
 3. From the kdb prompt you can run the ``help`` command to see a complete
    list of the commands that are available.
@@ -460,7 +460,7 @@ This is a quick example of how to use kdb with a keyboard.
 
 2. Enter the kernel debugger manually or by waiting for an oops or
    fault. There are several ways you can enter the kernel debugger
-   manually; all involve using the :kbd:`SysRq-G`, which means you must have
+   manually; all involve using the `SysRq-G`, which means you must have
    enabled ``CONFIG_MAGIC_SYSRQ=y`` in your kernel config.
 
    -  When logged in as root or with a super user session you can run::
@@ -469,27 +469,27 @@ This is a quick example of how to use kdb with a keyboard.
 
    -  Example using a laptop keyboard:
 
-      Press and hold down: :kbd:`Alt`
+      Press and hold down: `Alt`
 
-      Press and hold down: :kbd:`Fn`
+      Press and hold down: `Fn`
 
-      Press and release the key with the label: :kbd:`SysRq`
+      Press and release the key with the label: `SysRq`
 
-      Release: :kbd:`Fn`
+      Release: `Fn`
 
-      Press and release: :kbd:`g`
+      Press and release: `g`
 
-      Release: :kbd:`Alt`
+      Release: `Alt`
 
    -  Example using a PS/2 101-key keyboard
 
-      Press and hold down: :kbd:`Alt`
+      Press and hold down: `Alt`
 
-      Press and release the key with the label: :kbd:`SysRq`
+      Press and release the key with the label: `SysRq`
 
-      Press and release: :kbd:`g`
+      Press and release: `g`
 
-      Release: :kbd:`Alt`
+      Release: `Alt`
 
 3. Now type in a kdb command such as ``help``, ``dmesg``, ``bt`` or ``go`` to
    continue kernel execution.
@@ -531,7 +531,7 @@ Connecting with gdb to a serial port
 
    In order to connect to gdb via kgdboc, the kernel must first be
    stopped. There are several ways to stop the kernel which include
-   using kgdbwait as a boot argument, via a :kbd:`SysRq-G`, or running the
+   using kgdbwait as a boot argument, via a `SysRq-G`, or running the
    kernel until it takes an exception where it waits for the debugger to
    attach.
 
@@ -541,16 +541,16 @@ Connecting with gdb to a serial port
 
    -  Example using minicom 2.2
 
-      Press: :kbd:`CTRL-A` :kbd:`f` :kbd:`g`
+      Press: `CTRL-A` `f` `g`
 
    -  When you have telneted to a terminal server that supports sending
       a remote break
 
-      Press: :kbd:`CTRL-]`
+      Press: `CTRL-]`
 
       Type in: ``send break``
 
-      Press: :kbd:`Enter` :kbd:`g`
+      Press: `Enter` `g`
 
 3. Connect from gdb
 
@@ -578,7 +578,7 @@ Connecting with gdb to a serial port
 	set debug remote 1
 
 Remember if you continue in gdb, and need to "break in" again, you need
-to issue an other :kbd:`SysRq-G`. It is easy to create a simple entry point by
+to issue an other `SysRq-G`. It is easy to create a simple entry point by
 putting a breakpoint at ``sys_sync`` and then you can run ``sync`` from a
 shell or script to break into the debugger.
 
@@ -612,7 +612,7 @@ or delete because kgdb will interpret that as part of the debug stream.
 
    .. note::
 
-     Now you must kill gdb. Typically you press :kbd:`CTRL-Z` and issue
+     Now you must kill gdb. Typically you press `CTRL-Z` and issue
      the command::
 
 	kill -9 %
diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index e6b9173a18..84a2450bb6 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -86,7 +86,7 @@ In the :menuselection:`Sending Preferences` section:
 - :menuselection:`Strip Whitespace Before Sending` must be ``disabled``
 
 When composing the message, the cursor should be placed where the patch
-should appear, and then pressing :kbd:`CTRL-R` let you specify the patch file
+should appear, and then pressing `CTRL-R` let you specify the patch file
 to insert into the message.
 
 Claws Mail (GUI)
@@ -94,7 +94,7 @@ Claws Mail (GUI)
 
 Works. Some people use this successfully for patches.
 
-To insert a patch use :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`)
+To insert a patch use :menuselection:`Message-->Insert File` (`CTRL-I`)
 or an external editor.
 
 If the inserted patch has to be edited in the Claws composition window
@@ -108,11 +108,11 @@ Evolution (GUI)
 Some people use this successfully for patches.
 
 When composing mail select: Preformat
-  from :menuselection:`Format-->Paragraph Style-->Preformatted` (:kbd:`CTRL-7`)
+  from :menuselection:`Format-->Paragraph Style-->Preformatted` (`CTRL-7`)
   or the toolbar
 
 Then use:
-:menuselection:`Insert-->Text File...` (:kbd:`ALT-N x`)
+:menuselection:`Insert-->Text File...` (`ALT-N x`)
 to insert the patch.
 
 You can also ``diff -Nru old.c new.c | xclip``, select
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 6cb8b676ce..6d83df3dd7 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -16,12 +16,12 @@ programs - the BPF scheduler.
 * The system integrity is maintained no matter what the BPF scheduler does.
   The default scheduling behavior is restored anytime an error is detected,
   a runnable task stalls, or on invoking the SysRq key sequence
-  :kbd:`SysRq-S`.
+  `SysRq-S`.
 
 * When the BPF scheduler triggers an error, debug information is dumped to
   aid debugging. The debug dump is passed to and printed out by the
   scheduler binary. The debug dump can also be accessed through the
-  `sched_ext_dump` tracepoint. The SysRq key sequence :kbd:`SysRq-D`
+  `sched_ext_dump` tracepoint. The SysRq key sequence `SysRq-D`
   triggers a debug dump. This doesn't terminate the BPF scheduler and can
   only be read through the tracepoint.
 
@@ -59,7 +59,7 @@ set in ``ops->flags``, only tasks with the ``SCHED_EXT`` policy are scheduled
 by sched_ext, while tasks with ``SCHED_NORMAL``, ``SCHED_BATCH`` and
 ``SCHED_IDLE`` policies are scheduled by CFS.
 
-Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
+Terminating the sched_ext scheduler program, triggering `SysRq-S`, or
 detection of any internal error including stalled runnable tasks aborts the
 BPF scheduler and reverts all tasks back to CFS.
 
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 97173746d8..9f8fe8abab 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -95,7 +95,7 @@ Nella sezione :menuselection:`Sending Preferences`:
 - :menuselection:`Strip Whitespace Before Sending` deve essere ``disabled``
 
 Quando state scrivendo un messaggio, il cursore dev'essere posizionato
-dove volete che la patch inizi, poi premendo :kbd:`CTRL-R` vi verrà chiesto
+dove volete che la patch inizi, poi premendo `CTRL-R` vi verrà chiesto
 di selezionare il file patch da inserire nel messaggio.
 
 Claws Mail (GUI)
@@ -104,7 +104,7 @@ Claws Mail (GUI)
 Funziona. Alcune persone riescono ad usarlo con successo per inviare le patch.
 
 Per inserire una patch usate :menuselection:`Messaggio-->Inserisci file`
-(:kbd:`CTRL-I`) oppure un editor esterno.
+(`CTRL-I`) oppure un editor esterno.
 
 Se la patch che avete inserito dev'essere modificata usando la finestra di
 scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
@@ -117,10 +117,10 @@ Alcune persone riescono ad usarlo con successo per inviare le patch.
 
 Quando state scrivendo una lettera selezionate: Preformattato
   da :menuselection:`Formato-->Stile del paragrafo-->Preformattato`
-  (:kbd:`CTRL-7`) o dalla barra degli strumenti
+  (`CTRL-7`) o dalla barra degli strumenti
 
 Poi per inserire la patch usate:
-:menuselection:`Inserisci--> File di testo...` (:kbd:`ALT-N x`)
+:menuselection:`Inserisci--> File di testo...` (`ALT-N x`)
 
 Potete anche eseguire ``diff -Nru old.c new.c | xclip``, selezionare
 :menuselection:`Preformattato`, e poi usare il tasto centrale del mouse.
diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
index 55d5803daf..f60b091ac9 100644
--- a/Documentation/translations/sp_SP/process/email-clients.rst
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -96,7 +96,7 @@ En la sección :menuselection:`Sending Preferences`:
 - :menuselection:`Strip Whitespace Before Sending` debe estar ``disabled``
 
 Al redactar el mensaje, el cursor debe colocarse donde el parche debería
-aparecer, y luego presionando :kbd:`CTRL-R` se le permite especificar e
+aparecer, y luego presionando `CTRL-R` se le permite especificar e
 archivo de parche a insertar en el mensaje.
 
 Claws Mail (GUI)
@@ -104,7 +104,7 @@ Claws Mail (GUI)
 
 Funciona. Algunos usan esto con éxito para los parches.
 
-Para insertar un parche haga :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`)
+Para insertar un parche haga :menuselection:`Message-->Insert File` (`CTRL-I`)
 o use un editor externo.
 
 Si el parche insertado debe editarse en la ventana de composición de Claws
@@ -118,11 +118,11 @@ Evolution (GUI)
 Algunos usan esto con éxito para sus parches.
 
 Cuando escriba un correo seleccione: Preformat
-  desde :menuselection:`Format-->Paragraph Style-->Preformatted` (:kbd:`CTRL-7`)
+  desde :menuselection:`Format-->Paragraph Style-->Preformatted` (`CTRL-7`)
   o en la barra de herramientas
 
 Luego haga:
-:menuselection:`Insert-->Text File...` (:kbd:`ALT-N x`)
+:menuselection:`Insert-->Text File...` (`ALT-N x`)
 para insertar el parche.
 
 También puede hacer ``diff -Nru old.c new.c | xclip``, seleccione
diff --git a/Documentation/translations/zh_CN/admin-guide/sysrq.rst b/Documentation/translations/zh_CN/admin-guide/sysrq.rst
index 8276d70f3b..6b100acc4e 100644
--- a/Documentation/translations/zh_CN/admin-guide/sysrq.rst
+++ b/Documentation/translations/zh_CN/admin-guide/sysrq.rst
@@ -60,24 +60,24 @@ CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE 必须是以 16 进制数写入。
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 在 x86 架构上
-	你可以按下键盘组合键 :kbd:`ALT-SysRq-<command key>`。
+	你可以按下键盘组合键 `ALT-SysRq-<command key>`。
 
 	.. note::
 	   一些键盘可能没有标识 'SySRq' 键。'SySRq' 键也被当做 'Print Screen'键。
-	   同时有些键盘无法处理同时按下这么多键，因此你可以先按下键盘 :kbd:`Alt` 键，
-	   然后按下键盘 :kbd:`SysRq` 键，再释放键盘 :kbd:`SysRq` 键，之后按下键盘上命令键
-	   :kbd:`<command key>`，最后释放所有键。
+	   同时有些键盘无法处理同时按下这么多键，因此你可以先按下键盘 `Alt` 键，
+	   然后按下键盘 `SysRq` 键，再释放键盘 `SysRq` 键，之后按下键盘上命令键
+	   `<command key>`，最后释放所有键。
 
 在 SPARC 架构上
-	你可以按下键盘组合键 :kbd:`ALT-STOP-<command key>` 。
+	你可以按下键盘组合键 `ALT-STOP-<command key>` 。
 
 在串行控制台（只针对 PC 类型的标准串口）
         你可以发一个 ``BREAK`` ，然后在 5 秒内发送一个命令键，
 	发送 ``BREAK`` 两次将被翻译为一个正常的 BREAK 操作。
 
 在 PowerPC 架构上
-	按下键盘组合键 :kbd:`ALT - Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令键>` 。
-        :kbd:`Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令键>` 或许也能实现。
+	按下键盘组合键 `ALT - Print Screen` （或者 `F13`） - `<命令键>` 。
+        `Print Screen` （或者 `F13`） - `<命令键>` 或许也能实现。
 
 在其他架构上
 	如果你知道其他架构的组合键，请告诉我，我可以把它们添加到这部分。
@@ -87,7 +87,7 @@ CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE 必须是以 16 进制数写入。
 
 		echo t > /proc/sysrq-trigger
 
-这个命令键 :kbd:`<command key>` 是区分大小写的。
+这个命令键 `<command key>` 是区分大小写的。
 
 什么是命令键？
 ~~~~~~~~~~~~~~
@@ -203,8 +203,8 @@ syslogd/klogd 进程是运行的，它们仍将被记录。）
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 这也会发生在我这，我发现轻敲键盘两侧的 shift、alt 和 control 键，然后再次敲击
-一个无效的 SysRq 键序列可以解决问题。（比如，像键盘组合键 :kbd:`alt-sysrq-z` ）
-切换到另一个虚拟控制台（键盘操作 :kbd:`ALT+Fn` ），然后再切回来应该也有帮助。
+一个无效的 SysRq 键序列可以解决问题。（比如，像键盘组合键 `alt-sysrq-z` ）
+切换到另一个虚拟控制台（键盘操作 `ALT+Fn` ），然后再切回来应该也有帮助。
 
 我敲击了 SysRq 键，但像是什么都没发生，发生了什么错误？
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -259,7 +259,7 @@ SysRq 键的输出和所有其他控制台输出一样，受制于控制台日
 文件的消费访问到。作为一个特例，来自 sysrq 命令的标题行将被传递给所有控制台
 使用者，就好像当前日志级别是最大的一样。如果只发出标题头，则几乎可以肯定内核日志
 级别太低。如果你需要控制台上的输出，那么你将需要临时提高控制台日志级别，通过使用
-键盘组合键 :kbd:`alt-sysrq-8` 或者::
+键盘组合键 `alt-sysrq-8` 或者::
 
     echo 8 > /proc/sysrq-trigger
 
diff --git a/Documentation/translations/zh_CN/process/email-clients.rst b/Documentation/translations/zh_CN/process/email-clients.rst
index a70393089d..069c0460d2 100644
--- a/Documentation/translations/zh_CN/process/email-clients.rst
+++ b/Documentation/translations/zh_CN/process/email-clients.rst
@@ -85,7 +85,7 @@ Alpine (TUI)
 - :menuselection:`Do Not Send Flowed Text` 必须开启
 - :menuselection:`Strip Whitespace Before Sending` 必须关闭
 
-当写邮件时，光标应该放在补丁会出现的地方，然后按下 :kbd:`CTRL-R` 组合键，使指
+当写邮件时，光标应该放在补丁会出现的地方，然后按下 `CTRL-R` 组合键，使指
 定的补丁文件嵌入到邮件中。
 
 Claws Mail (GUI)
@@ -93,7 +93,7 @@ Claws Mail (GUI)
 
 可以用，有人用它成功地发过补丁。
 
-用 :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`) 或外置编辑器插入补丁。
+用 :menuselection:`Message-->Insert File` (`CTRL-I`) 或外置编辑器插入补丁。
 
 若要在Claws编辑窗口重修改插入的补丁，需关闭
 :menuselection:`Configuration-->Preferences-->Compose-->Wrapping`
@@ -105,11 +105,11 @@ Evolution (GUI)
 一些开发者成功的使用它发送补丁。
 
 撰写邮件时：
-从 :menuselection:`格式-->段落样式-->预格式化` (:kbd:`CTRL-7`)
+从 :menuselection:`格式-->段落样式-->预格式化` (`CTRL-7`)
 或工具栏选择 :menuselection:`预格式化` ；
 
 然后使用：
-:menuselection:`插入-->文本文件...` (:kbd:`ALT-N x`) 插入补丁文件。
+:menuselection:`插入-->文本文件...` (`ALT-N x`) 插入补丁文件。
 
 你还可以 ``diff -Nru old.c new.c | xclip`` ，选择 :menuselection:`预格式化` ，
 然后使用鼠标中键进行粘帖。
diff --git a/Documentation/translations/zh_TW/admin-guide/sysrq.rst b/Documentation/translations/zh_TW/admin-guide/sysrq.rst
index 4a08db00a4..4979e5d540 100644
--- a/Documentation/translations/zh_TW/admin-guide/sysrq.rst
+++ b/Documentation/translations/zh_TW/admin-guide/sysrq.rst
@@ -60,24 +60,24 @@ CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE 必須是以 16 進制數寫入。
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 在 x86 架構上
-	你可以按下鍵盤組合鍵 :kbd:`ALT-SysRq-<command key>`。
+	你可以按下鍵盤組合鍵 `ALT-SysRq-<command key>`。
 
 	.. note::
 	   一些鍵盤可能沒有標識 'SySRq' 鍵。'SySRq' 鍵也被當做 'Print Screen'鍵。
-	   同時有些鍵盤無法處理同時按下這麼多鍵，因此你可以先按下鍵盤 :kbd:`Alt` 鍵，
-	   然後按下鍵盤 :kbd:`SysRq` 鍵，再釋放鍵盤 :kbd:`SysRq` 鍵，之後按下鍵盤上命令鍵
-	   :kbd:`<command key>`，最後釋放所有鍵。
+	   同時有些鍵盤無法處理同時按下這麼多鍵，因此你可以先按下鍵盤 `Alt` 鍵，
+	   然後按下鍵盤 `SysRq` 鍵，再釋放鍵盤 `SysRq` 鍵，之後按下鍵盤上命令鍵
+	   `<command key>`，最後釋放所有鍵。
 
 在 SPARC 架構上
-	你可以按下鍵盤組合鍵 :kbd:`ALT-STOP-<command key>` 。
+	你可以按下鍵盤組合鍵 `ALT-STOP-<command key>` 。
 
 在串行控制檯（只針對 PC 類型的標準串口）
         你可以發一個 ``BREAK`` ，然後在 5 秒內發送一個命令鍵，
 	發送 ``BREAK`` 兩次將被翻譯爲一個正常的 BREAK 操作。
 
 在 PowerPC 架構上
-	按下鍵盤組合鍵 :kbd:`ALT - Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令鍵>` 。
-        :kbd:`Print Screen` （或者 :kbd:`F13`） - :kbd:`<命令鍵>` 或許也能實現。
+	按下鍵盤組合鍵 `ALT - Print Screen` （或者 `F13`） - `<命令鍵>` 。
+        `Print Screen` （或者 `F13`） - `<命令鍵>` 或許也能實現。
 
 在其他架構上
 	如果你知道其他架構的組合鍵，請告訴我，我可以把它們添加到這部分。
@@ -87,7 +87,7 @@ CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE 必須是以 16 進制數寫入。
 
 		echo t > /proc/sysrq-trigger
 
-這個命令鍵 :kbd:`<command key>` 是區分大小寫的。
+這個命令鍵 `<command key>` 是區分大小寫的。
 
 什麼是命令鍵？
 ~~~~~~~~~~~~~~
@@ -203,8 +203,8 @@ syslogd/klogd 進程是運行的，它們仍將被記錄。）
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 這也會發生在我這，我發現輕敲鍵盤兩側的 shift、alt 和 control 鍵，然後再次敲擊
-一個無效的 SysRq 鍵序列可以解決問題。（比如，像鍵盤組合鍵 :kbd:`alt-sysrq-z` ）
-切換到另一個虛擬控制檯（鍵盤操作 :kbd:`ALT+Fn` ），然後再切回來應該也有幫助。
+一個無效的 SysRq 鍵序列可以解決問題。（比如，像鍵盤組合鍵 `alt-sysrq-z` ）
+切換到另一個虛擬控制檯（鍵盤操作 `ALT+Fn` ），然後再切回來應該也有幫助。
 
 我敲擊了 SysRq 鍵，但像是什麼都沒發生，發生了什麼錯誤？
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -259,7 +259,7 @@ SysRq 鍵的輸出和所有其他控制檯輸出一樣，受制於控制檯日
 文件的消費訪問到。作爲一個特例，來自 sysrq 命令的標題行將被傳遞給所有控制檯
 使用者，就好像當前日誌級別是最大的一樣。如果只發出標題頭，則幾乎可以肯定內核日誌
 級別太低。如果你需要控制檯上的輸出，那麼你將需要臨時提高控制檯日誌級別，通過使用
-鍵盤組合鍵 :kbd:`alt-sysrq-8` 或者::
+鍵盤組合鍵 `alt-sysrq-8` 或者::
 
     echo 8 > /proc/sysrq-trigger
 
diff --git a/Documentation/translations/zh_TW/process/email-clients.rst b/Documentation/translations/zh_TW/process/email-clients.rst
index a5ac9400a9..4543c447d7 100644
--- a/Documentation/translations/zh_TW/process/email-clients.rst
+++ b/Documentation/translations/zh_TW/process/email-clients.rst
@@ -86,7 +86,7 @@ Alpine (TUI)
 - :menuselection:`Do Not Send Flowed Text` 必須開啓
 - :menuselection:`Strip Whitespace Before Sending` 必須關閉
 
-當寫郵件時，光標應該放在補丁會出現的地方，然後按下 :kbd:`CTRL-R` 組合鍵，使指
+當寫郵件時，光標應該放在補丁會出現的地方，然後按下 `CTRL-R` 組合鍵，使指
 定的補丁文件嵌入到郵件中。
 
 Claws Mail (GUI)
@@ -94,7 +94,7 @@ Claws Mail (GUI)
 
 可以用，有人用它成功地發過補丁。
 
-用 :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`) 或外置編輯器插入補丁。
+用 :menuselection:`Message-->Insert File` (`CTRL-I`) 或外置編輯器插入補丁。
 
 若要在Claws編輯窗口重修改插入的補丁，需關閉
 :menuselection:`Configuration-->Preferences-->Compose-->Wrapping`
@@ -106,11 +106,11 @@ Evolution (GUI)
 一些開發者成功的使用它發送補丁。
 
 撰寫郵件時：
-從 :menuselection:`格式-->段落樣式-->預格式化` (:kbd:`CTRL-7`)
+從 :menuselection:`格式-->段落樣式-->預格式化` (`CTRL-7`)
 或工具欄選擇 :menuselection:`預格式化` ；
 
 然後使用：
-:menuselection:`插入-->文本文件...` (:kbd:`ALT-N x`) 插入補丁文件。
+:menuselection:`插入-->文本文件...` (`ALT-N x`) 插入補丁文件。
 
 你還可以 ``diff -Nru old.c new.c | xclip`` ，選擇 :menuselection:`預格式化` ，
 然後使用鼠標中鍵進行粘帖。
-- 
2.43.0


