Return-Path: <linux-kernel+bounces-413539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8699D1ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0369B23FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23AC1E885E;
	Mon, 18 Nov 2024 21:41:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF61E8821
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966078; cv=none; b=fQ6h0wAtA12ZWG9LtLu5/kl2NL0/8yfw0SSF/NrUSocN3KNXEwA76y+2DUjcbH8/daHb0csaWQdOBCPMSAKmoeXnkBZo6dRhN0jN+EmmUJ1Y1iqFeg0fTOUgyO3Tgcvz2tYu3Xt8rNTamS52uRULRKkw96vghXpGMZJ5JMikXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966078; c=relaxed/simple;
	bh=9jmM3A4kv4i1p8BHzYN2KcQ+8Jhsx84dLmtKtiHkF6c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qqOVpWT1Vi0L3k21QsViev+hxiEBEHdqrTfGFOjLTfrWAiMmMuECjJO0Q+iP8aONtjx4I/PLR2plF4C5yD443wzVDWWx+Nd6/ztpjESxbnp/bZkpA9iPLXpiDmr/xMBZcj/5ZJ5x6ONsUatoO7ckBeik16EFyK4BNXok/wv71Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B230C4CECC;
	Mon, 18 Nov 2024 21:41:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD9VG-0000000DO69-1cc8;
	Mon, 18 Nov 2024 16:41:50 -0500
Message-ID: <20241118214150.235297619@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 16:41:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 5/5] verification/dot2: Improve dot parser robustness
References: <20241118214122.136581969@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

This patch makes the dot parser used by dot2c and dot2k slightly more
robust, namely:
* allows parsing files with the gv extension (GraphViz)
* correctly parses edges with any indentation
    * used to work only with a single character (e.g. '\t')
Additionally it fixes a couple of warnings reported by pylint such as
wrong indentation and comparison to False instead of `not ...`

Link: https://lore.kernel.org/20241017064238.41394-2-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/automata.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index baffeb960ff0..bdeb98baa8b0 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -29,11 +29,11 @@ class Automata:
 
     def __get_model_name(self):
         basename = ntpath.basename(self.__dot_path)
-        if basename.endswith(".dot") == False:
+        if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
             raise Exception("not a dot file: %s" % self.__dot_path)
 
-        model_name = basename[0:-4]
+        model_name = ntpath.splitext(basename)[0]
         if model_name.__len__() == 0:
             raise Exception("not a dot file: %s" % self.__dot_path)
 
@@ -68,9 +68,9 @@ class Automata:
     def __get_cursor_begin_events(self):
         cursor = 0
         while self.__dot_lines[cursor].split()[0] != "{node":
-           cursor += 1
+            cursor += 1
         while self.__dot_lines[cursor].split()[0] == "{node":
-           cursor += 1
+            cursor += 1
         # skip initial state transition
         cursor += 1
         return cursor
@@ -94,11 +94,11 @@ class Automata:
                 initial_state = state[7:]
             else:
                 states.append(state)
-                if self.__dot_lines[cursor].__contains__("doublecircle") == True:
+                if "doublecircle" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
-                if self.__dot_lines[cursor].__contains__("ellipse") == True:
+                if "ellipse" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
@@ -110,7 +110,7 @@ class Automata:
         # Insert the initial state at the bein og the states
         states.insert(0, initial_state)
 
-        if has_final_states == False:
+        if not has_final_states:
             final_states.append(initial_state)
 
         return states, initial_state, final_states
@@ -120,7 +120,7 @@ class Automata:
         cursor = self.__get_cursor_begin_events()
 
         events = []
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
             #  ------------ event is here ------------^^^^^
@@ -161,7 +161,7 @@ class Automata:
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
 
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')
-- 
2.45.2



