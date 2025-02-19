Return-Path: <linux-kernel+bounces-521113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E8A3B44A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8253A73C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BC1D6DB1;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHM6CJLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438A1DE2BE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=G57din5didBDB+eall6tg8qCvAAKxSB6sGReDvsVmaNnJ/prtwUEFnVTLuoUcvEuhdGQPkX7YCHfJtxHb4ZC8Exh9Xolj0QLNj4mt+n+xerv8kQVp4dNdA93wmHrPCiwPkhe/ZXbsdiun0Pw776fMZMQ3J5g4M7+ZZDV/ReDC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=2to40pLeg8q0+VRpVnj4qXIaza6aM03uTe1Bu/KQtIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdIjkK3sA31gshmf8kmU/IOsunKES0Rzrlenf6RoxqOHqWrh7woRhEkggIQRRpKH5AcidYtoFXL4uUhgaQL5s7NXkdSnTcvruNYs/fSz/VnQzGYB/JgbAWjSwVg6lq0xnR0AwqsLwV7zh2iFTbdQQWlibLm9ruCd3fPzUkHNiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHM6CJLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D06DC4CEFA;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=2to40pLeg8q0+VRpVnj4qXIaza6aM03uTe1Bu/KQtIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHM6CJLyZmC3+lgPADbu6GYg8HsLe7dTLfULnlNN5LWrsQUHv9zamtDEElrGCA3GL
	 DJeVTYupRdvs6WBn/x9cMgOiz0sjE4qC1Cip/tnpjYELs86GMP3j1vcAC7sXJ4F/b0
	 b939th7cnQzMU8SObA/4WTOSOKCrNlY+qfR+v389KULStqlJJDe3n5/8frbEy3r2vc
	 2b9yeottJFaJMmdwLApAqh52mhj6TFA3R7Vow0v6nYvLsepB4yf95rUKY8WZ2L631U
	 Tdu+Sb3/rLNGIxfZw/aDkEgTUABBaWACT66f0ACUZLu6ffZ+3YvpFastegpMk5kiI6
	 ZBq2cEygKyZDg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv57-19rA;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/27] scripts/kernel-doc.py: move regex methods to a separate file
Date: Wed, 19 Feb 2025 09:32:29 +0100
Message-ID: <518d077882e30f07923f8d746ba5fa0e4429c361.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
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


