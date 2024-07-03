Return-Path: <linux-kernel+bounces-240153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB89269AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A77E1C21759
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B26190679;
	Wed,  3 Jul 2024 20:42:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8A1369A0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039369; cv=none; b=MhyRrb84H0yLFYUujBqojWrKm9siTVbAUpA/Y5niSAEyHBd7oI5sb6Qz5ptkEZEVo8L2lSJ0aXvCxeqVatzZZcyZd5PZkNwTVYsW/GoTAsYFKy+ychMIaaezlGG2eu27Qvgd6VycEyCi5dByDThEhmLRLDqHXXizltxi16wdJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039369; c=relaxed/simple;
	bh=wq+w7PujNWZnEd5aACvBTq2DLByFAXSVhKl1DS7FYEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=keQGObO86NoGA6zF7jZrZq3RDzHzJD2MVJTq/HEergjPw+90craYZKXE79AbciGzoe5662W48M4IJuurT0Nazy2e82t0jUuadWb8tJHVkFDIhPq1NEkc64d9lXH5/XQOnzS34DwmRiBVEgj7JRTzdPQthAcFl8peiplTgthrJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364B3C2BD10;
	Wed,  3 Jul 2024 20:42:48 +0000 (UTC)
Date: Wed, 3 Jul 2024 16:42:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Dmitry V. Levin" <ldv@strace.io>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [for-linus][PATCH] tracing: Have memmapped ring buffer use ioctl of
 "R" range 0x20-2F
Message-ID: <20240703164247.34096efa@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


It was reported that the ioctl() number used to update the ring buffer
memory mapping conflicted with the TCGETS ioctl causing strace to report:

  $ strace -e ioctl stty
  ioctl(0, TCGETS or TRACE_MMAP_IOCTL_GET_READER, {c_iflag=ICRNL|IXON, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD, c_lflag=ISIG|ICANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) = 0

Since this ioctl hasn't been in a full release yet, change it from "T", 0x1
to "R" 0x20, and also reserve 0x20-0x2F for future ioctl commands, as
some more are being worked on for the future.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 4ecaf7e98a3ae0c843d67c76649ecc694232834b


Steven Rostedt (Google) (1):
      tracing: Have memmapped ring buffer use ioctl of "R" range 0x20-2F

----
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 include/uapi/linux/trace_mmap.h                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---------------------------
commit 4ecaf7e98a3ae0c843d67c76649ecc694232834b
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Tue Jul 2 15:33:54 2024 -0400

    tracing: Have memmapped ring buffer use ioctl of "R" range 0x20-2F
    
    To prevent conflicts with other ioctl numbers to allow strace to have an
    idea of what is happening, add the range of ioctls for the trace buffer
    mapping from _IO("T", 0x1) to the range of "R" 0x20 - 0x2F.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240630105322.GA17573@altlinux.org/
    Link: https://lore.kernel.org/linux-trace-kernel/20240630213626.GA23566@altlinux.org/
    
    Cc: Jonathan Corbet <corbet@lwn.net>
    Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
    Link: https://lore.kernel.org/20240702153354.367861db@rorschach.local.home
    Reported-by: "Dmitry V. Levin" <ldv@strace.io>
    Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..9a97030c6c8d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
+'R'   20-2F  linux/trace_mmap.h
 'R'   C0-DF  net/bluetooth/rfcomm.h
 'R'   E0     uapi/linux/fsl_mc.h
 'S'   all    linux/cdrom.h                                           conflict!
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index bd1066754220..c102ef35d11e 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,6 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
-#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
 
 #endif /* _TRACE_MMAP_H_ */

