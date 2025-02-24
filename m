Return-Path: <linux-kernel+bounces-528508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4EA41881
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D94F1650EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45F257AEF;
	Mon, 24 Feb 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbzxkpIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8924A04E;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=ZPRUPh6RCCaLPrK1LQ2RDslRdfNf2y9WAqg7qVey3YPPumA1W9xyGh2W+rHOncu1fBWj9yH0+EVJiqyy5fBBg2h2unrErrVhWj23BgjxRcbNMJ7sk2LQjprivQGI3cSx01Vg93Yh6ZC2s+wD/W+p1G4hjhQTeFNIB1QTWE7CoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=2to40pLeg8q0+VRpVnj4qXIaza6aM03uTe1Bu/KQtIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9q6CvFVWtndt530iLM3yazInw6KUUIBTpEJLeWmo14FEsj784mFFzHA//c9bthCowxd7cCiLRbu3KI5PbxJWGK8+Nh0P5Vvnw9zCuKPTud80xRTHek5Yxu5VFS/6R94KcANvm8TNXHKagzej74PZbbV5lcenG+FeMlhDrJWYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbzxkpIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9606C4CEFA;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=2to40pLeg8q0+VRpVnj4qXIaza6aM03uTe1Bu/KQtIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbzxkpIl2YAxrMBEIRj9dDBT5nYy4iHyG2gAOsC1LYNfGnarih3L4Dv4UE7iF/YlJ
	 vESgy27JopNcQUSF6FpbEI0nGVnaiJ/quFGV309RP0b2Dizd0VRmTCY3GX5REL/EAv
	 DZ6fYmyA78xcehuIBcWVovc8dL8ydIOZMa2lqUFcH4rseqVm7y7q4j18yxqWQb1rEd
	 DYf/n3m3JbR0Ltaxk5Iu65H5HKpiKo4f8+P9aFV7FJvoLS982DNc8XaHspXxS8GuJ6
	 hiJTLVSASwi1La3cg73Cn7VWLTL2o/U8bqpdyQ//oV9aol0n5OtR8i7UU67zSYYb7m
	 z6B4r5lNlLk1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4G-0bAo;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/39] scripts/kernel-doc.py: move regex methods to a separate file
Date: Mon, 24 Feb 2025 10:08:19 +0100
Message-ID: <c57e97b6f4bc4c743c56ea529a501f494efa5cb1.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

In preparation for letting kerneldoc Sphinx extension to import
Python libraries, move regex ancillary classes to a separate
file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py       | 223 +----------------------------
 scripts/lib/kdoc/kdoc_re.py | 272 ++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+), 218 deletions(-)
 create mode 100755 scripts/lib/kdoc/kdoc_re.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 3decc94edb1e..faae66aa6ead 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -35,228 +35,15 @@ from pprint import pformat
 
 from dateutil import tz
 
-# Local cache for regular expressions
-re_cache = {}
+# Import Python modules
 
+LIB_DIR = "lib/kdoc"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
-class Re:
-    """
-    Helper class to simplify regex declaration and usage,
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-    It calls re.compile for a given pattern. It also allows adding
-    regular expressions and define sub at class init time.
+from kdoc_re import Re, NestedMatch
 
-    Regular expressions can be cached via an argument, helping to speedup
-    searches.
-    """
-
-    def _add_regex(self, string, flags):
-        if string in re_cache:
-            self.regex = re_cache[string]
-        else:
-            self.regex = re.compile(string, flags=flags)
-
-            if self.cache:
-                re_cache[string] = self.regex
-
-    def __init__(self, string, cache=True, flags=0):
-        self.cache = cache
-        self.last_match = None
-
-        self._add_regex(string, flags)
-
-    def __str__(self):
-        return self.regex.pattern
-
-    def __add__(self, other):
-        return Re(str(self) + str(other), cache=self.cache or other.cache,
-                  flags=self.regex.flags | other.regex.flags)
-
-    def match(self, string):
-        self.last_match = self.regex.match(string)
-        return self.last_match
-
-    def search(self, string):
-        self.last_match = self.regex.search(string)
-        return self.last_match
-
-    def findall(self, string):
-        return self.regex.findall(string)
-
-    def split(self, string):
-        return self.regex.split(string)
-
-    def sub(self, sub, string, count=0):
-        return self.regex.sub(sub, string, count=count)
-
-    def group(self, num):
-        return self.last_match.group(num)
-
-class NestedMatch:
-    """
-    Finding nested delimiters is hard with regular expressions. It is
-    even harder on Python with its normal re module, as there are several
-    advanced regular expressions that are missing.
-
-    This is the case of this pattern:
-
-            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
-
-    which is used to properly match open/close parenthesis of the
-    string search STRUCT_GROUP(),
-
-    Add a class that counts pairs of delimiters, using it to match and
-    replace nested expressions.
-
-    The original approach was suggested by:
-        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
-
-    Although I re-implemented it to make it more generic and match 3 types
-    of delimiters. The logic checks if delimiters are paired. If not, it
-    will ignore the search string.
-    """
-
-    # TODO:
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter's aligned.
-    #
-    # The content inside parenthesis are converted into a single replace
-    # group (e.g. r`\1').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to.
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
-
-
-    DELIMITER_PAIRS = {
-        '{': '}',
-        '(': ')',
-        '[': ']',
-    }
-
-    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
-
-    def _search(self, regex, line):
-        """
-        Finds paired blocks for a regex that ends with a delimiter.
-
-        The suggestion of using finditer to match pairs came from:
-        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
-        but I ended using a different implementation to align all three types
-        of delimiters and seek for an initial regular expression.
-
-        The algorithm seeks for open/close paired delimiters and place them
-        into a stack, yielding a start/stop position of each match  when the
-        stack is zeroed.
-
-        The algorithm shoud work fine for properly paired lines, but will
-        silently ignore end delimiters that preceeds an start delimiter.
-        This should be OK for kernel-doc parser, as unaligned delimiters
-        would cause compilation errors. So, we don't need to rise exceptions
-        to cover such issues.
-        """
-
-        stack = []
-
-        for match_re in regex.finditer(line):
-            start = match_re.start()
-            offset = match_re.end()
-
-            d = line[offset -1]
-            if d not in self.DELIMITER_PAIRS:
-                continue
-
-            end = self.DELIMITER_PAIRS[d]
-            stack.append(end)
-
-            for match in self.RE_DELIM.finditer(line[offset:]):
-                pos = match.start() + offset
-
-                d = line[pos]
-
-                if d in self.DELIMITER_PAIRS:
-                    end = self.DELIMITER_PAIRS[d]
-
-                    stack.append(end)
-                    continue
-
-                # Does the end delimiter match what it is expected?
-                if stack and d == stack[-1]:
-                    stack.pop()
-
-                    if not stack:
-                        yield start, offset, pos + 1
-                        break
-
-    def search(self, regex, line):
-        """
-        This is similar to re.search:
-
-        It matches a regex that it is followed by a delimiter,
-        returning occurrences only if all delimiters are paired.
-        """
-
-        for t in self._search(regex, line):
-
-            yield line[t[0]:t[2]]
-
-    def sub(self, regex, sub, line, count=0):
-        """
-        This is similar to re.sub:
-
-        It matches a regex that it is followed by a delimiter,
-        replacing occurrences only if all delimiters are paired.
-
-        if r'\1' is used, it works just like re: it places there the
-        matched paired data with the delimiter stripped.
-
-        If count is different than zero, it will replace at most count
-        items.
-        """
-        out = ""
-
-        cur_pos = 0
-        n = 0
-
-        found = False
-        for start, end, pos in self._search(regex, line):
-            out += line[cur_pos:start]
-
-            # Value, ignoring start/end delimiters
-            value = line[end:pos - 1]
-
-            # replaces \1 at the sub string, if \1 is used there
-            new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
-
-            out += new_sub
-
-            # Drop end ';' if any
-            if line[pos] == ';':
-                pos += 1
-
-            cur_pos = pos
-            n += 1
-
-            if count and count >= n:
-                break
-
-        # Append the remaining string
-        l = len(line)
-        out += line[cur_pos:l]
-
-        return out
 
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
new file mode 100755
index 000000000000..45ddba8090e5
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_re.py
@@ -0,0 +1,272 @@
+#!/usr/bin/env python3
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Regular expression ancillary classes.
+
+Those help caching regular expressions and do matching for kernel-doc.
+"""
+
+import re
+
+# Local cache for regular expressions
+re_cache = {}
+
+
+class Re:
+    """
+    Helper class to simplify regex declaration and usage,
+
+    It calls re.compile for a given pattern. It also allows adding
+    regular expressions and define sub at class init time.
+
+    Regular expressions can be cached via an argument, helping to speedup
+    searches.
+    """
+
+    def _add_regex(self, string, flags):
+        """
+        Adds a new regex or re-use it from the cache.
+        """
+
+        if string in re_cache:
+            self.regex = re_cache[string]
+        else:
+            self.regex = re.compile(string, flags=flags)
+
+            if self.cache:
+                re_cache[string] = self.regex
+
+    def __init__(self, string, cache=True, flags=0):
+        """
+        Compile a regular expression and initialize internal vars.
+        """
+
+        self.cache = cache
+        self.last_match = None
+
+        self._add_regex(string, flags)
+
+    def __str__(self):
+        """
+        Return the regular expression pattern.
+        """
+        return self.regex.pattern
+
+    def __add__(self, other):
+        """
+        Allows adding two regular expressions into one.
+        """
+
+        return Re(str(self) + str(other), cache=self.cache or other.cache,
+                  flags=self.regex.flags | other.regex.flags)
+
+    def match(self, string):
+        """
+        Handles a re.match storing its results
+        """
+
+        self.last_match = self.regex.match(string)
+        return self.last_match
+
+    def search(self, string):
+        """
+        Handles a re.search storing its results
+        """
+
+        self.last_match = self.regex.search(string)
+        return self.last_match
+
+    def findall(self, string):
+        """
+        Alias to re.findall
+        """
+
+        return self.regex.findall(string)
+
+    def split(self, string):
+        """
+        Alias to re.split
+        """
+
+        return self.regex.split(string)
+
+    def sub(self, sub, string, count=0):
+        """
+        Alias to re.sub
+        """
+
+        return self.regex.sub(sub, string, count=count)
+
+    def group(self, num):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.group(num)
+
+
+class NestedMatch:
+    """
+    Finding nested delimiters is hard with regular expressions. It is
+    even harder on Python with its normal re module, as there are several
+    advanced regular expressions that are missing.
+
+    This is the case of this pattern:
+
+            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
+
+    which is used to properly match open/close parenthesis of the
+    string search STRUCT_GROUP(),
+
+    Add a class that counts pairs of delimiters, using it to match and
+    replace nested expressions.
+
+    The original approach was suggested by:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+
+    Although I re-implemented it to make it more generic and match 3 types
+    of delimiters. The logic checks if delimiters are paired. If not, it
+    will ignore the search string.
+    """
+
+    # TODO:
+    # Right now, regular expressions to match it are defined only up to
+    #       the start delimiter, e.g.:
+    #
+    #       \bSTRUCT_GROUP\(
+    #
+    # is similar to: STRUCT_GROUP\((.*)\)
+    # except that the content inside the match group is delimiter's aligned.
+    #
+    # The content inside parenthesis are converted into a single replace
+    # group (e.g. r`\1').
+    #
+    # It would be nice to change such definition to support multiple
+    # match groups, allowing a regex equivalent to.
+    #
+    #   FOO\((.*), (.*), (.*)\)
+    #
+    # it is probably easier to define it not as a regular expression, but
+    # with some lexical definition like:
+    #
+    #   FOO(arg1, arg2, arg3)
+
+    DELIMITER_PAIRS = {
+        '{': '}',
+        '(': ')',
+        '[': ']',
+    }
+
+    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
+
+    def _search(self, regex, line):
+        """
+        Finds paired blocks for a regex that ends with a delimiter.
+
+        The suggestion of using finditer to match pairs came from:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+        but I ended using a different implementation to align all three types
+        of delimiters and seek for an initial regular expression.
+
+        The algorithm seeks for open/close paired delimiters and place them
+        into a stack, yielding a start/stop position of each match  when the
+        stack is zeroed.
+
+        The algorithm shoud work fine for properly paired lines, but will
+        silently ignore end delimiters that preceeds an start delimiter.
+        This should be OK for kernel-doc parser, as unaligned delimiters
+        would cause compilation errors. So, we don't need to rise exceptions
+        to cover such issues.
+        """
+
+        stack = []
+
+        for match_re in regex.finditer(line):
+            start = match_re.start()
+            offset = match_re.end()
+
+            d = line[offset - 1]
+            if d not in self.DELIMITER_PAIRS:
+                continue
+
+            end = self.DELIMITER_PAIRS[d]
+            stack.append(end)
+
+            for match in self.RE_DELIM.finditer(line[offset:]):
+                pos = match.start() + offset
+
+                d = line[pos]
+
+                if d in self.DELIMITER_PAIRS:
+                    end = self.DELIMITER_PAIRS[d]
+
+                    stack.append(end)
+                    continue
+
+                # Does the end delimiter match what it is expected?
+                if stack and d == stack[-1]:
+                    stack.pop()
+
+                    if not stack:
+                        yield start, offset, pos + 1
+                        break
+
+    def search(self, regex, line):
+        """
+        This is similar to re.search:
+
+        It matches a regex that it is followed by a delimiter,
+        returning occurrences only if all delimiters are paired.
+        """
+
+        for t in self._search(regex, line):
+
+            yield line[t[0]:t[2]]
+
+    def sub(self, regex, sub, line, count=0):
+        """
+        This is similar to re.sub:
+
+        It matches a regex that it is followed by a delimiter,
+        replacing occurrences only if all delimiters are paired.
+
+        if r'\1' is used, it works just like re: it places there the
+        matched paired data with the delimiter stripped.
+
+        If count is different than zero, it will replace at most count
+        items.
+        """
+        out = ""
+
+        cur_pos = 0
+        n = 0
+
+        for start, end, pos in self._search(regex, line):
+            out += line[cur_pos:start]
+
+            # Value, ignoring start/end delimiters
+            value = line[end:pos - 1]
+
+            # replaces \1 at the sub string, if \1 is used there
+            new_sub = sub
+            new_sub = new_sub.replace(r'\1', value)
+
+            out += new_sub
+
+            # Drop end ';' if any
+            if line[pos] == ';':
+                pos += 1
+
+            cur_pos = pos
+            n += 1
+
+            if count and count >= n:
+                break
+
+        # Append the remaining string
+        l = len(line)
+        out += line[cur_pos:l]
+
+        return out
-- 
2.48.1


