Return-Path: <linux-kernel+bounces-572824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5ABA6CF26
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E171816A13B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB49204F71;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF31C8604
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732950; cv=none; b=rexjKEocgz5cAi0xEsgSGDo6pLjURrBxWGfjOutASqDgnBIzKOxCCPZF2KqJnHvhqTZnDCEZiEP1QE7KZwFchaNokZCww2x8lq4XfMRAzhnI2CdySy7EnHDMC9D0M79DLQE6WCsArM3IAIXXG1MpiTGvfxLKhqfUpPZXA8/aSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732950; c=relaxed/simple;
	bh=mac9E2reOOVM6xy+JAuu3a3ABPbtI6G6MycBtkaDQno=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a6xDy9XoqrnuhPSeNhe/PzVqVQsatoF0/u/XQO9XVuJzUCKQUtLQVnr2bMq3bR1Xd/T25oc39lnu+0pHn4YR9UoNqwlum8P7FWSFri1onTRaLQULzQD24k2+OovOnxXayy+r722BJAmLRZy2pEWobxfJ61rzEIKoHBu+xsaH16k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B19C4CEEE;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSb-00000001ydm-1VSU;
	Sun, 23 Mar 2025 08:29:49 -0400
Message-ID: <20250323122949.208190772@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Uday Shankar <ushankar@purestorage.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [for-next][PATCH 01/10] scripts/tracing: Remove scripts/tracing/draw_functrace.py
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The draw_functrace.py hasn't worked in years. There's better ways to
accomplish the same thing (via libtracefs). Remove it.

Link: https://lore.kernel.org/linux-trace-kernel/20250210-debuginfo-v1-1-368feb58292a@purestorage.com/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Uday Shankar <ushankar@purestorage.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/20250307103941.070654e7@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/tracing/draw_functrace.py | 129 ------------------------------
 1 file changed, 129 deletions(-)
 delete mode 100755 scripts/tracing/draw_functrace.py

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
deleted file mode 100755
index 42fa87300941..000000000000
--- a/scripts/tracing/draw_functrace.py
+++ /dev/null
@@ -1,129 +0,0 @@
-#!/usr/bin/env python
-# SPDX-License-Identifier: GPL-2.0-only
-
-"""
-Copyright 2008 (c) Frederic Weisbecker <fweisbec@gmail.com>
-
-This script parses a trace provided by the function tracer in
-kernel/trace/trace_functions.c
-The resulted trace is processed into a tree to produce a more human
-view of the call stack by drawing textual but hierarchical tree of
-calls. Only the functions's names and the call time are provided.
-
-Usage:
-	Be sure that you have CONFIG_FUNCTION_TRACER
-	# mount -t tracefs nodev /sys/kernel/tracing
-	# echo function > /sys/kernel/tracing/current_tracer
-	$ cat /sys/kernel/tracing/trace_pipe > ~/raw_trace_func
-	Wait some times but not too much, the script is a bit slow.
-	Break the pipe (Ctrl + Z)
-	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
-	Then you have your drawn trace in draw_functrace
-"""
-
-
-import sys, re
-
-class CallTree:
-	""" This class provides a tree representation of the functions
-		call stack. If a function has no parent in the kernel (interrupt,
-		syscall, kernel thread...) then it is attached to a virtual parent
-		called ROOT.
-	"""
-	ROOT = None
-
-	def __init__(self, func, time = None, parent = None):
-		self._func = func
-		self._time = time
-		if parent is None:
-			self._parent = CallTree.ROOT
-		else:
-			self._parent = parent
-		self._children = []
-
-	def calls(self, func, calltime):
-		""" If a function calls another one, call this method to insert it
-			into the tree at the appropriate place.
-			@return: A reference to the newly created child node.
-		"""
-		child = CallTree(func, calltime, self)
-		self._children.append(child)
-		return child
-
-	def getParent(self, func):
-		""" Retrieve the last parent of the current node that
-			has the name given by func. If this function is not
-			on a parent, then create it as new child of root
-			@return: A reference to the parent.
-		"""
-		tree = self
-		while tree != CallTree.ROOT and tree._func != func:
-			tree = tree._parent
-		if tree == CallTree.ROOT:
-			child = CallTree.ROOT.calls(func, None)
-			return child
-		return tree
-
-	def __repr__(self):
-		return self.__toString("", True)
-
-	def __toString(self, branch, lastChild):
-		if self._time is not None:
-			s = "%s----%s (%s)\n" % (branch, self._func, self._time)
-		else:
-			s = "%s----%s\n" % (branch, self._func)
-
-		i = 0
-		if lastChild:
-			branch = branch[:-1] + " "
-		while i < len(self._children):
-			if i != len(self._children) - 1:
-				s += "%s" % self._children[i].__toString(branch +\
-								"    |", False)
-			else:
-				s += "%s" % self._children[i].__toString(branch +\
-								"    |", True)
-			i += 1
-		return s
-
-class BrokenLineException(Exception):
-	"""If the last line is not complete because of the pipe breakage,
-	   we want to stop the processing and ignore this line.
-	"""
-	pass
-
-class CommentLineException(Exception):
-	""" If the line is a comment (as in the beginning of the trace file),
-	    just ignore it.
-	"""
-	pass
-
-
-def parseLine(line):
-	line = line.strip()
-	if line.startswith("#"):
-		raise CommentLineException
-	m = re.match("[^]]+?\\] +([a-z.]+) +([0-9.]+): (\\w+) <-(\\w+)", line)
-	if m is None:
-		raise BrokenLineException
-	return (m.group(2), m.group(3), m.group(4))
-
-
-def main():
-	CallTree.ROOT = CallTree("Root (Nowhere)", None, None)
-	tree = CallTree.ROOT
-
-	for line in sys.stdin:
-		try:
-			calltime, callee, caller = parseLine(line)
-		except BrokenLineException:
-			break
-		except CommentLineException:
-			continue
-		tree = tree.getParent(caller)
-		tree = tree.calls(callee, calltime)
-
-	print(CallTree.ROOT)
-
-if __name__ == "__main__":
-	main()
-- 
2.47.2



