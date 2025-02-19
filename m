Return-Path: <linux-kernel+bounces-521116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25658A3B451
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E87B188FE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091371E5732;
	Wed, 19 Feb 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYpsAxUp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2F1DE2DE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953973; cv=none; b=eoAAeKc6RPRaMnKzo07QoiGHPoYzXjDX+8t9OmbQHrsSQv/LkR2Wuj0imXNuo7+/jSKDH+/81UVCWrjyt68NKsGMKggbn7rL3nqwMfXmstRSk43i7W6iUhiWQa8DN0kvtJOijgWEketmvpNv9r1u44pz9gFUJv/v001AuW9zBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953973; c=relaxed/simple;
	bh=hPv6z9fZFY9mkuOaJfh9tzYOURGM+7iDxiBMcb2e6xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYBFtSE2nJLBzcnFVpKO1GIEgbJRvRDw+sCerK95rDgx1oMSeibZNQ42zTFjka3pkyX7ERWUPEqtDbBXcYpjYRXiwNbY1Ghld4KfS1Fo+CALxRg2IJXEe2lbbndG/eiPSi7PVXyC8zVbULGtWXOwrGYYyX22JOsvryDlA1O+tNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYpsAxUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C4EC4CEFE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=hPv6z9fZFY9mkuOaJfh9tzYOURGM+7iDxiBMcb2e6xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYpsAxUpm0rM5lweENK33/SIDOyvQRVtVjMsDoxk8j35T49ObulauvT92N80h0DgL
	 vcvGkqJjaXHbdoCtu8bgvLqyE60ppiAlqGdRRy/dJwbu/8Nttt0X3+WBEtNUjxOXWb
	 nyA8vOrZc4iYwEryJfO1/qTDKKIffWYE1+CLVsbw2RoxuNrzbV2sCDdHckfAIOOKnj
	 G3VFPxIAuoyyU+mOk9DU8ZiJXZJE4M2xo6Twb7VZcxJeXsLiaGvI7bG5U7kKPlsivs
	 cT5mnHtCiIS23iav9snjd9IMQNrT6L+JbqOwQG6VamXE9ChRpn/ttX7Q97wxZ/uATA
	 XRgTTgz0MY/gg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5J-1Wso;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/27] scripts/kernel-doc.py: move output classes to a separate file
Date: Wed, 19 Feb 2025 09:32:32 +0100
Message-ID: <64f56c12fef462cc9e22d7f11ae0ff818a4081ad.1739952783.git.mchehab+huawei@kernel.org>
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
Python libraries, move kernel-doc output logic to a separate file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           | 727 +------------------------------
 scripts/lib/kdoc/kdoc_output.py | 735 ++++++++++++++++++++++++++++++++
 2 files changed, 738 insertions(+), 724 deletions(-)
 create mode 100755 scripts/lib/kdoc/kdoc_output.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index cd79b2c1b746..0596c711d448 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -1,7 +1,5 @@
 #!/usr/bin/env python3
-# pylint: disable=R0902,R0903,R0904,R0911,R0912,R0913,R0914,R0915,R0917,R1702
-# pylint: disable=C0302,C0103,C0301
-# pylint: disable=C0116,C0115,W0511,W0613
+# pylint: disable=C0103,
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 # SPDX-License-Identifier: GPL-2.0
 
@@ -27,14 +25,8 @@ documentation comment syntax.
 import argparse
 import logging
 import os
-import re
 import sys
 
-from datetime import datetime
-from pprint import pformat
-
-from dateutil import tz
-
 # Import Python modules
 
 LIB_DIR = "lib/kdoc"
@@ -42,721 +34,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from kdoc_parser import KernelDoc, type_param
-from kdoc_re import Re
-from kdoc_files import KernelFiles
-
-function_pointer = Re(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
-
-# match expressions used to find embedded type information
-type_constant = Re(r"\b``([^\`]+)``\b", cache=False)
-type_constant2 = Re(r"\%([-_*\w]+)", cache=False)
-type_func = Re(r"(\w+)\(\)", cache=False)
-type_param_ref = Re(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
-
-# Special RST handling for func ptr params
-type_fp_param = Re(r"\@(\w+)\(\)", cache=False)
-
-# Special RST handling for structs with func ptr params
-type_fp_param2 = Re(r"\@(\w+->\S+)\(\)", cache=False)
-
-type_env = Re(r"(\$\w+)", cache=False)
-type_enum = Re(r"\&(enum\s*([_\w]+))", cache=False)
-type_struct = Re(r"\&(struct\s*([_\w]+))", cache=False)
-type_typedef = Re(r"\&(typedef\s*([_\w]+))", cache=False)
-type_union = Re(r"\&(union\s*([_\w]+))", cache=False)
-type_member = Re(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
-type_fallback = Re(r"\&([_\w]+)", cache=False)
-type_member_func = type_member + Re(r"\(\)", cache=False)
-
-
-class OutputFormat:
-    # output mode.
-    OUTPUT_ALL          = 0 # output all symbols and doc sections
-    OUTPUT_INCLUDE      = 1 # output only specified symbols
-    OUTPUT_EXPORTED     = 2 # output exported symbols
-    OUTPUT_INTERNAL     = 3 # output non-exported symbols
-
-    # Virtual member to be overriden at the  inherited classes
-    highlights = []
-
-    def __init__(self):
-        """Declare internal vars and set mode to OUTPUT_ALL"""
-
-        self.out_mode = self.OUTPUT_ALL
-        self.enable_lineno = None
-        self.nosymbol = {}
-        self.symbol = None
-        self.function_table = set()
-        self.config = None
-
-    def set_config(self, config):
-        self.config = config
-
-    def set_filter(self, export, internal, symbol, nosymbol, function_table,
-                   enable_lineno):
-        """
-        Initialize filter variables according with the requested mode.
-
-        Only one choice is valid between export, internal and symbol.
-
-        The nosymbol filter can be used on all modes.
-        """
-
-        self.enable_lineno = enable_lineno
-
-        if symbol:
-            self.out_mode = self.OUTPUT_INCLUDE
-            function_table = symbol
-        elif export:
-            self.out_mode = self.OUTPUT_EXPORTED
-        elif internal:
-            self.out_mode = self.OUTPUT_INTERNAL
-        else:
-            self.out_mode = self.OUTPUT_ALL
-
-        if nosymbol:
-            self.nosymbol = set(nosymbol)
-
-        if function_table:
-            self.function_table = function_table
-
-    def highlight_block(self, block):
-        """
-        Apply the RST highlights to a sub-block of text.
-        """
-
-        for r, sub in self.highlights:
-            block = r.sub(sub, block)
-
-        return block
-
-    def check_doc(self, name):
-        """Check if DOC should be output"""
-
-        if self.out_mode == self.OUTPUT_ALL:
-            return True
-
-        if self.out_mode == self.OUTPUT_INCLUDE:
-            if name in self.nosymbol:
-                return False
-
-            if name in self.function_table:
-                return True
-
-        return False
-
-    def check_declaration(self, dtype, name):
-        if name in self.nosymbol:
-            return False
-
-        if self.out_mode == self.OUTPUT_ALL:
-            return True
-
-        if self.out_mode in [ self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED ]:
-            if name in self.function_table:
-                return True
-
-        if self.out_mode == self.OUTPUT_INTERNAL:
-            if dtype != "function":
-                return True
-
-            if name not in self.function_table:
-                return True
-
-        return False
-
-    def check_function(self, fname, name, args):
-        return True
-
-    def check_enum(self, fname, name, args):
-        return True
-
-    def check_typedef(self, fname, name, args):
-        return True
-
-    def msg(self, fname, name, args):
-
-        dtype = args.get('type', "")
-
-        if dtype == "doc":
-            self.out_doc(fname, name, args)
-            return False
-
-        if not self.check_declaration(dtype, name):
-            return False
-
-        if dtype == "function":
-            self.out_function(fname, name, args)
-            return False
-
-        if dtype == "enum":
-            self.out_enum(fname, name, args)
-            return False
-
-        if dtype == "typedef":
-            self.out_typedef(fname, name, args)
-            return False
-
-        if dtype in ["struct", "union"]:
-            self.out_struct(fname, name, args)
-            return False
-
-        # Warn if some type requires an output logic
-        self.config.log.warning("doesn't now how to output '%s' block",
-                                dtype)
-
-        return True
-
-    # Virtual methods to be overridden by inherited classes
-    def out_doc(self, fname, name, args):
-        pass
-
-    def out_function(self, fname, name, args):
-        pass
-
-    def out_enum(self, fname, name, args):
-        pass
-
-    def out_typedef(self, fname, name, args):
-        pass
-
-    def out_struct(self, fname, name, args):
-        pass
-
-
-class RestFormat(OutputFormat):
-    # """Consts and functions used by ReST output"""
-
-    highlights = [
-        (type_constant, r"``\1``"),
-        (type_constant2, r"``\1``"),
-
-        # Note: need to escape () to avoid func matching later
-        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
-        (type_member, r":c:type:`\1\2\3 <\1>`"),
-        (type_fp_param, r"**\1\\(\\)**"),
-        (type_fp_param2, r"**\1\\(\\)**"),
-        (type_func, r"\1()"),
-        (type_enum, r":c:type:`\1 <\2>`"),
-        (type_struct, r":c:type:`\1 <\2>`"),
-        (type_typedef, r":c:type:`\1 <\2>`"),
-        (type_union, r":c:type:`\1 <\2>`"),
-
-        # in rst this can refer to any type
-        (type_fallback, r":c:type:`\1`"),
-        (type_param_ref, r"**\1\2**")
-    ]
-    blankline = "\n"
-
-    sphinx_literal = Re(r'^[^.].*::$', cache=False)
-    sphinx_cblock = Re(r'^\.\.\ +code-block::', cache=False)
-
-    def __init__(self):
-        """
-        Creates class variables.
-
-        Not really mandatory, but it is a good coding style and makes
-        pylint happy.
-        """
-
-        super().__init__()
-        self.lineprefix = ""
-
-    def print_lineno (self, ln):
-        """Outputs a line number"""
-
-        if self.enable_lineno and ln:
-            print(f".. LINENO {ln}")
-
-    def output_highlight(self, args):
-        input_text = args
-        output = ""
-        in_literal = False
-        litprefix = ""
-        block = ""
-
-        for line in input_text.strip("\n").split("\n"):
-
-            # If we're in a literal block, see if we should drop out of it.
-            # Otherwise, pass the line straight through unmunged.
-            if in_literal:
-                if line.strip():  # If the line is not blank
-                    # If this is the first non-blank line in a literal block,
-                    # figure out the proper indent.
-                    if not litprefix:
-                        r = Re(r'^(\s*)')
-                        if r.match(line):
-                            litprefix = '^' + r.group(1)
-                        else:
-                            litprefix = ""
-
-                        output += line + "\n"
-                    elif not Re(litprefix).match(line):
-                        in_literal = False
-                    else:
-                        output += line + "\n"
-                else:
-                    output += line + "\n"
-
-            # Not in a literal block (or just dropped out)
-            if not in_literal:
-                block += line + "\n"
-                if self.sphinx_literal.match(line) or self.sphinx_cblock.match(line):
-                    in_literal = True
-                    litprefix = ""
-                    output += self.highlight_block(block)
-                    block = ""
-
-        # Handle any remaining block
-        if block:
-            output += self.highlight_block(block)
-
-        # Print the output with the line prefix
-        for line in output.strip("\n").split("\n"):
-            print(self.lineprefix + line)
-
-    def out_section(self, args, out_reference=False):
-        """
-        Outputs a block section.
-
-        This could use some work; it's used to output the DOC: sections, and
-        starts by putting out the name of the doc section itself, but that
-        tends to duplicate a header already in the template file.
-        """
-
-        sectionlist = args.get('sectionlist', [])
-        sections = args.get('sections', {})
-        section_start_lines = args.get('section_start_lines', {})
-
-        for section in sectionlist:
-            # Skip sections that are in the nosymbol_table
-            if section in self.nosymbol:
-                continue
-
-            if not self.out_mode == self.OUTPUT_INCLUDE:
-                if out_reference:
-                    print(f".. _{section}:\n")
-
-                if not self.symbol:
-                    print(f'{self.lineprefix}**{section}**\n')
-
-            self.print_lineno(section_start_lines.get(section, 0))
-            self.output_highlight(sections[section])
-            print()
-        print()
-
-    def out_doc(self, fname, name, args):
-        if not self.check_doc(name):
-            return
-
-        self.out_section(args, out_reference=True)
-
-    def out_function(self, fname, name, args):
-
-        oldprefix = self.lineprefix
-        signature = ""
-
-        func_macro = args.get('func_macro', False)
-        if func_macro:
-            signature = args['function']
-        else:
-            if args.get('functiontype'):
-                signature = args['functiontype'] + " "
-            signature += args['function'] + " ("
-
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
-
-        ln = args.get('ln', 0)
-
-        count = 0
-        for parameter in parameterlist:
-            if count != 0:
-                signature += ", "
-            count += 1
-            dtype = args['parametertypes'].get(parameter, "")
-
-            if function_pointer.search(dtype):
-                signature += function_pointer.group(1) + parameter + function_pointer.group(3)
-            else:
-                signature += dtype
-
-        if not func_macro:
-            signature += ")"
-
-        if args.get('typedef') or not args.get('functiontype'):
-            print(f".. c:macro:: {args['function']}\n")
-
-            if args.get('typedef'):
-                self.print_lineno(ln)
-                print("   **Typedef**: ", end="")
-                self.lineprefix = ""
-                self.output_highlight(args.get('purpose', ""))
-                print("\n\n**Syntax**\n")
-                print(f"  ``{signature}``\n")
-            else:
-                print(f"``{signature}``\n")
-        else:
-            print(f".. c:function:: {signature}\n")
-
-        if not args.get('typedef'):
-            self.print_lineno(ln)
-            self.lineprefix = "   "
-            self.output_highlight(args.get('purpose', ""))
-            print()
-
-        # Put descriptive text into a container (HTML <div>) to help set
-        # function prototypes apart
-        self.lineprefix = "  "
-
-        if parameterlist:
-            print(".. container:: kernelindent\n")
-            print(f"{self.lineprefix}**Parameters**\n")
-
-        for parameter in parameterlist:
-            parameter_name = Re(r'\[.*').sub('', parameter)
-            dtype = args['parametertypes'].get(parameter, "")
-
-            if dtype:
-                print(f"{self.lineprefix}``{dtype}``")
-            else:
-                print(f"{self.lineprefix}``{parameter}``")
-
-            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
-
-            self.lineprefix = "    "
-            if parameter_name in parameterdescs and \
-               parameterdescs[parameter_name] != KernelDoc.undescribed:
-
-                self.output_highlight(parameterdescs[parameter_name])
-                print()
-            else:
-                print(f"{self.lineprefix}*undescribed*\n")
-            self.lineprefix = "  "
-
-        self.out_section(args)
-        self.lineprefix = oldprefix
-
-    def out_enum(self, fname, name, args):
-
-        oldprefix = self.lineprefix
-        name = args.get('enum', '')
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        ln = args.get('ln', 0)
-
-        print(f"\n\n.. c:enum:: {name}\n")
-
-        self.print_lineno(ln)
-        self.lineprefix = "  "
-        self.output_highlight(args.get('purpose', ''))
-        print()
-
-        print(".. container:: kernelindent\n")
-        outer = self.lineprefix + "  "
-        self.lineprefix = outer + "  "
-        print(f"{outer}**Constants**\n")
-
-        for parameter in parameterlist:
-            print(f"{outer}``{parameter}``")
-
-            if parameterdescs.get(parameter, '') != KernelDoc.undescribed:
-                self.output_highlight(parameterdescs[parameter])
-            else:
-                print(f"{self.lineprefix}*undescribed*\n")
-            print()
-
-        self.lineprefix = oldprefix
-        self.out_section(args)
-
-    def out_typedef(self, fname, name, args):
-
-        oldprefix = self.lineprefix
-        name = args.get('typedef', '')
-        ln = args.get('ln', 0)
-
-        print(f"\n\n.. c:type:: {name}\n")
-
-        self.print_lineno(ln)
-        self.lineprefix = "   "
-
-        self.output_highlight(args.get('purpose', ''))
-
-        print()
-
-        self.lineprefix = oldprefix
-        self.out_section(args)
-
-    def out_struct(self, fname, name, args):
-
-        name = args.get('struct', "")
-        purpose = args.get('purpose', "")
-        declaration = args.get('definition', "")
-        dtype = args.get('type', "struct")
-        ln = args.get('ln', 0)
-
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
-
-        print(f"\n\n.. c:{dtype}:: {name}\n")
-
-        self.print_lineno(ln)
-
-        oldprefix = self.lineprefix
-        self.lineprefix += "  "
-
-        self.output_highlight(purpose)
-        print()
-
-        print(".. container:: kernelindent\n")
-        print(f"{self.lineprefix}**Definition**::\n")
-
-        self.lineprefix = self.lineprefix + "  "
-
-        declaration = declaration.replace("\t", self.lineprefix)
-
-        print(f"{self.lineprefix}{dtype} {name}" + ' {')
-        print(f"{declaration}{self.lineprefix}" + "};\n")
-
-        self.lineprefix = "  "
-        print(f"{self.lineprefix}**Members**\n")
-        for parameter in parameterlist:
-            if not parameter or parameter.startswith("#"):
-                continue
-
-            parameter_name = parameter.split("[", maxsplit=1)[0]
-
-            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
-                continue
-
-            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
-
-            print(f"{self.lineprefix}``{parameter}``")
-
-            self.lineprefix = "    "
-            self.output_highlight(parameterdescs[parameter_name])
-            self.lineprefix = "  "
-
-            print()
-
-        print()
-
-        self.lineprefix = oldprefix
-        self.out_section(args)
-
-
-class ManFormat(OutputFormat):
-    """Consts and functions used by man pages output"""
-
-    highlights = (
-        (type_constant, r"\1"),
-        (type_constant2, r"\1"),
-        (type_func, r"\\fB\1\\fP"),
-        (type_enum, r"\\fI\1\\fP"),
-        (type_struct, r"\\fI\1\\fP"),
-        (type_typedef, r"\\fI\1\\fP"),
-        (type_union, r"\\fI\1\\fP"),
-        (type_param, r"\\fI\1\\fP"),
-        (type_param_ref, r"\\fI\1\2\\fP"),
-        (type_member, r"\\fI\1\2\3\\fP"),
-        (type_fallback, r"\\fI\1\\fP")
-    )
-    blankline = ""
-
-    def __init__(self):
-        """
-        Creates class variables.
-
-        Not really mandatory, but it is a good coding style and makes
-        pylint happy.
-        """
-
-        super().__init__()
-
-        dt = datetime.now()
-        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
-            # use UTC TZ
-            to_zone = tz.gettz('UTC')
-            dt = dt.astimezone(to_zone)
-
-        self.man_date = dt.strftime("%B %Y")
-
-    def output_highlight(self, block):
-
-        contents = self.highlight_block(block)
-
-        if isinstance(contents, list):
-            contents = "\n".join(contents)
-
-        for line in contents.strip("\n").split("\n"):
-            line = Re(r"^\s*").sub("", line)
-
-            if line and line[0] == ".":
-                print("\\&" + line)
-            else:
-                print(line)
-
-    def out_doc(self, fname, name, args):
-        module = args.get('module')
-        sectionlist = args.get('sectionlist', [])
-        sections = args.get('sections', {})
-
-        print(f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX')
-
-        for section in sectionlist:
-            print(f'.SH "{section}"')
-            self.output_highlight(sections.get(section))
-
-    def out_function(self, fname, name, args):
-        """output function in man"""
-
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        sectionlist = args.get('sectionlist', [])
-        sections = args.get('sections', {})
-
-        print(f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX')
-
-        print(".SH NAME")
-        print(f"{args['function']} \\- {args['purpose']}")
-
-        print(".SH SYNOPSIS")
-        if args.get('functiontype', ''):
-            print(f'.B "{args['functiontype']}" {args['function']}')
-        else:
-            print(f'.B "{args['function']}')
-
-        count = 0
-        parenth = "("
-        post = ","
-
-        for parameter in parameterlist:
-            if count == len(parameterlist) - 1:
-                post = ");"
-
-            dtype = args['parametertypes'].get(parameter, "")
-            if function_pointer.match(dtype):
-                # Pointer-to-function
-                print(f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"')
-            else:
-                dtype = Re(r'([^\*])$').sub(r'\1 ', dtype)
-
-                print(f'.BI "{parenth}{dtype}"  "{post}"')
-            count += 1
-            parenth = ""
-
-        if parameterlist:
-            print(".SH ARGUMENTS")
-
-        for parameter in parameterlist:
-            parameter_name = re.sub(r'\[.*', '', parameter)
-
-            print(f'.IP "{parameter}" 12')
-            self.output_highlight(parameterdescs.get(parameter_name, ""))
-
-        for section in sectionlist:
-            print(f'.SH "{section.upper()}"')
-            self.output_highlight(sections[section])
-
-    def out_enum(self, fname, name, args):
-
-        name = args.get('enum', '')
-        parameterlist = args.get('parameterlist', [])
-        sectionlist = args.get('sectionlist', [])
-        sections = args.get('sections', {})
-
-        print(f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX')
-
-        print(".SH NAME")
-        print(f"enum {args['enum']} \\- {args['purpose']}")
-
-        print(".SH SYNOPSIS")
-        print(f"enum {args['enum']}" + " {")
-
-        count = 0
-        for parameter in parameterlist:
-            print(f'.br\n.BI "    {parameter}"')
-            if count == len(parameterlist) - 1:
-                print("\n};")
-            else:
-                print(", \n.br")
-
-            count += 1
-
-        print(".SH Constants")
-
-        for parameter in parameterlist:
-            parameter_name = Re(r'\[.*').sub('', parameter)
-            print(f'.IP "{parameter}" 12')
-            self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
-
-        for section in sectionlist:
-            print(f'.SH "{section}"')
-            self.output_highlight(sections[section])
-
-    def out_typedef(self, fname, name, args):
-        module = args.get('module')
-        typedef = args.get('typedef')
-        purpose = args.get('purpose')
-        sectionlist = args.get('sectionlist', [])
-        sections = args.get('sections', {})
-
-        print(f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX')
-
-        print(".SH NAME")
-        print(f"typedef {typedef} \\- {purpose}")
-
-        for section in sectionlist:
-            print(f'.SH "{section}"')
-            self.output_highlight(sections.get(section))
-
-    def out_struct(self, fname, name, args):
-        module = args.get('module')
-        struct_type = args.get('type')
-        struct_name = args.get('struct')
-        purpose = args.get('purpose')
-        definition = args.get('definition')
-        sectionlist = args.get('sectionlist', [])
-        parameterlist = args.get('parameterlist', [])
-        sections = args.get('sections', {})
-        parameterdescs = args.get('parameterdescs', {})
-
-        print(f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX')
-
-        print(".SH NAME")
-        print(f"{struct_type} {struct_name} \\- {purpose}")
-
-        # Replace tabs with two spaces and handle newlines
-        declaration = definition.replace("\t", "  ")
-        declaration = Re(r"\n").sub('"\n.br\n.BI "', declaration)
-
-        print(".SH SYNOPSIS")
-        print(f"{struct_type} {struct_name} " + "{" +"\n.br")
-        print(f'.BI "{declaration}\n' + "};\n.br\n")
-
-        print(".SH Members")
-        for parameter in parameterlist:
-            if parameter.startswith("#"):
-                continue
-
-            parameter_name = re.sub(r"\[.*", "", parameter)
-
-            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
-                continue
-
-            print(f'.IP "{parameter}" 12')
-            self.output_highlight(parameterdescs.get(parameter_name))
-
-        for section in sectionlist:
-            print(f'.SH "{section}"')
-            self.output_highlight(sections.get(section))
-
-
-# Command line interface
-
+from kdoc_files import KernelFiles                      # pylint: disable=C0413
+from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
 
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
new file mode 100755
index 000000000000..d080440caa1c
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -0,0 +1,735 @@
+#!/usr/bin/env python3
+# pylint: disable=C0301,R0911,R0912,R0913,R0914,R0915,R0917
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+# TODO: implement warning filtering
+
+"""
+Implement output filters to print kernel-doc documentation.
+
+The implementation uses a virtual base class (OutputFormat) which
+contains a dispatches to virtual methods, and some code to filter
+out output messages.
+
+The actual implementation is done on one separate class per each type
+of output. Currently, there are output classes for ReST and man/troff.
+"""
+
+import os
+import re
+from datetime import datetime
+
+from dateutil import tz
+
+from kdoc_parser import KernelDoc, type_param
+from kdoc_re import Re
+
+
+function_pointer = Re(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
+
+# match expressions used to find embedded type information
+type_constant = Re(r"\b``([^\`]+)``\b", cache=False)
+type_constant2 = Re(r"\%([-_*\w]+)", cache=False)
+type_func = Re(r"(\w+)\(\)", cache=False)
+type_param_ref = Re(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+
+# Special RST handling for func ptr params
+type_fp_param = Re(r"\@(\w+)\(\)", cache=False)
+
+# Special RST handling for structs with func ptr params
+type_fp_param2 = Re(r"\@(\w+->\S+)\(\)", cache=False)
+
+type_env = Re(r"(\$\w+)", cache=False)
+type_enum = Re(r"\&(enum\s*([_\w]+))", cache=False)
+type_struct = Re(r"\&(struct\s*([_\w]+))", cache=False)
+type_typedef = Re(r"\&(typedef\s*([_\w]+))", cache=False)
+type_union = Re(r"\&(union\s*([_\w]+))", cache=False)
+type_member = Re(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = Re(r"\&([_\w]+)", cache=False)
+type_member_func = type_member + Re(r"\(\)", cache=False)
+
+
+class OutputFormat:
+    # output mode.
+    OUTPUT_ALL          = 0 # output all symbols and doc sections
+    OUTPUT_INCLUDE      = 1 # output only specified symbols
+    OUTPUT_EXPORTED     = 2 # output exported symbols
+    OUTPUT_INTERNAL     = 3 # output non-exported symbols
+
+    # Virtual member to be overriden at the  inherited classes
+    highlights = []
+
+    def __init__(self):
+        """Declare internal vars and set mode to OUTPUT_ALL"""
+
+        self.out_mode = self.OUTPUT_ALL
+        self.enable_lineno = None
+        self.nosymbol = {}
+        self.symbol = None
+        self.function_table = set()
+        self.config = None
+
+    def set_config(self, config):
+        self.config = config
+
+    def set_filter(self, export, internal, symbol, nosymbol, function_table,
+                   enable_lineno):
+        """
+        Initialize filter variables according with the requested mode.
+
+        Only one choice is valid between export, internal and symbol.
+
+        The nosymbol filter can be used on all modes.
+        """
+
+        self.enable_lineno = enable_lineno
+
+        if symbol:
+            self.out_mode = self.OUTPUT_INCLUDE
+            function_table = symbol
+        elif export:
+            self.out_mode = self.OUTPUT_EXPORTED
+        elif internal:
+            self.out_mode = self.OUTPUT_INTERNAL
+        else:
+            self.out_mode = self.OUTPUT_ALL
+
+        if nosymbol:
+            self.nosymbol = set(nosymbol)
+
+        if function_table:
+            self.function_table = function_table
+
+    def highlight_block(self, block):
+        """
+        Apply the RST highlights to a sub-block of text.
+        """
+
+        for r, sub in self.highlights:
+            block = r.sub(sub, block)
+
+        return block
+
+    def check_doc(self, name):
+        """Check if DOC should be output"""
+
+        if self.out_mode == self.OUTPUT_ALL:
+            return True
+
+        if self.out_mode == self.OUTPUT_INCLUDE:
+            if name in self.nosymbol:
+                return False
+
+            if name in self.function_table:
+                return True
+
+        return False
+
+    def check_declaration(self, dtype, name):
+        if name in self.nosymbol:
+            return False
+
+        if self.out_mode == self.OUTPUT_ALL:
+            return True
+
+        if self.out_mode in [self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED]:
+            if name in self.function_table:
+                return True
+
+        if self.out_mode == self.OUTPUT_INTERNAL:
+            if dtype != "function":
+                return True
+
+            if name not in self.function_table:
+                return True
+
+        return False
+
+    def check_function(self, fname, name, args):
+        return True
+
+    def check_enum(self, fname, name, args):
+        return True
+
+    def check_typedef(self, fname, name, args):
+        return True
+
+    def msg(self, fname, name, args):
+
+        dtype = args.get('type', "")
+
+        if dtype == "doc":
+            self.out_doc(fname, name, args)
+            return False
+
+        if not self.check_declaration(dtype, name):
+            return False
+
+        if dtype == "function":
+            self.out_function(fname, name, args)
+            return False
+
+        if dtype == "enum":
+            self.out_enum(fname, name, args)
+            return False
+
+        if dtype == "typedef":
+            self.out_typedef(fname, name, args)
+            return False
+
+        if dtype in ["struct", "union"]:
+            self.out_struct(fname, name, args)
+            return False
+
+        # Warn if some type requires an output logic
+        self.config.log.warning("doesn't now how to output '%s' block",
+                                dtype)
+
+        return True
+
+    # Virtual methods to be overridden by inherited classes
+    def out_doc(self, fname, name, args):
+        pass
+
+    def out_function(self, fname, name, args):
+        pass
+
+    def out_enum(self, fname, name, args):
+        pass
+
+    def out_typedef(self, fname, name, args):
+        pass
+
+    def out_struct(self, fname, name, args):
+        pass
+
+
+class RestFormat(OutputFormat):
+    # """Consts and functions used by ReST output"""
+
+    highlights = [
+        (type_constant, r"``\1``"),
+        (type_constant2, r"``\1``"),
+
+        # Note: need to escape () to avoid func matching later
+        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
+        (type_member, r":c:type:`\1\2\3 <\1>`"),
+        (type_fp_param, r"**\1\\(\\)**"),
+        (type_fp_param2, r"**\1\\(\\)**"),
+        (type_func, r"\1()"),
+        (type_enum, r":c:type:`\1 <\2>`"),
+        (type_struct, r":c:type:`\1 <\2>`"),
+        (type_typedef, r":c:type:`\1 <\2>`"),
+        (type_union, r":c:type:`\1 <\2>`"),
+
+        # in rst this can refer to any type
+        (type_fallback, r":c:type:`\1`"),
+        (type_param_ref, r"**\1\2**")
+    ]
+    blankline = "\n"
+
+    sphinx_literal = Re(r'^[^.].*::$', cache=False)
+    sphinx_cblock = Re(r'^\.\.\ +code-block::', cache=False)
+
+    def __init__(self):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+        self.lineprefix = ""
+
+    def print_lineno(self, ln):
+        """Outputs a line number"""
+
+        if self.enable_lineno and ln:
+            print(f".. LINENO {ln}")
+
+    def output_highlight(self, args):
+        input_text = args
+        output = ""
+        in_literal = False
+        litprefix = ""
+        block = ""
+
+        for line in input_text.strip("\n").split("\n"):
+
+            # If we're in a literal block, see if we should drop out of it.
+            # Otherwise, pass the line straight through unmunged.
+            if in_literal:
+                if line.strip():  # If the line is not blank
+                    # If this is the first non-blank line in a literal block,
+                    # figure out the proper indent.
+                    if not litprefix:
+                        r = Re(r'^(\s*)')
+                        if r.match(line):
+                            litprefix = '^' + r.group(1)
+                        else:
+                            litprefix = ""
+
+                        output += line + "\n"
+                    elif not Re(litprefix).match(line):
+                        in_literal = False
+                    else:
+                        output += line + "\n"
+                else:
+                    output += line + "\n"
+
+            # Not in a literal block (or just dropped out)
+            if not in_literal:
+                block += line + "\n"
+                if self.sphinx_literal.match(line) or self.sphinx_cblock.match(line):
+                    in_literal = True
+                    litprefix = ""
+                    output += self.highlight_block(block)
+                    block = ""
+
+        # Handle any remaining block
+        if block:
+            output += self.highlight_block(block)
+
+        # Print the output with the line prefix
+        for line in output.strip("\n").split("\n"):
+            print(self.lineprefix + line)
+
+    def out_section(self, args, out_reference=False):
+        """
+        Outputs a block section.
+
+        This could use some work; it's used to output the DOC: sections, and
+        starts by putting out the name of the doc section itself, but that
+        tends to duplicate a header already in the template file.
+        """
+
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+        section_start_lines = args.get('section_start_lines', {})
+
+        for section in sectionlist:
+            # Skip sections that are in the nosymbol_table
+            if section in self.nosymbol:
+                continue
+
+            if not self.out_mode == self.OUTPUT_INCLUDE:
+                if out_reference:
+                    print(f".. _{section}:\n")
+
+                if not self.symbol:
+                    print(f'{self.lineprefix}**{section}**\n')
+
+            self.print_lineno(section_start_lines.get(section, 0))
+            self.output_highlight(sections[section])
+            print()
+        print()
+
+    def out_doc(self, fname, name, args):
+        if not self.check_doc(name):
+            return
+
+        self.out_section(args, out_reference=True)
+
+    def out_function(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        signature = ""
+
+        func_macro = args.get('func_macro', False)
+        if func_macro:
+            signature = args['function']
+        else:
+            if args.get('functiontype'):
+                signature = args['functiontype'] + " "
+            signature += args['function'] + " ("
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
+
+        ln = args.get('ln', 0)
+
+        count = 0
+        for parameter in parameterlist:
+            if count != 0:
+                signature += ", "
+            count += 1
+            dtype = args['parametertypes'].get(parameter, "")
+
+            if function_pointer.search(dtype):
+                signature += function_pointer.group(1) + parameter + function_pointer.group(3)
+            else:
+                signature += dtype
+
+        if not func_macro:
+            signature += ")"
+
+        if args.get('typedef') or not args.get('functiontype'):
+            print(f".. c:macro:: {args['function']}\n")
+
+            if args.get('typedef'):
+                self.print_lineno(ln)
+                print("   **Typedef**: ", end="")
+                self.lineprefix = ""
+                self.output_highlight(args.get('purpose', ""))
+                print("\n\n**Syntax**\n")
+                print(f"  ``{signature}``\n")
+            else:
+                print(f"``{signature}``\n")
+        else:
+            print(f".. c:function:: {signature}\n")
+
+        if not args.get('typedef'):
+            self.print_lineno(ln)
+            self.lineprefix = "   "
+            self.output_highlight(args.get('purpose', ""))
+            print()
+
+        # Put descriptive text into a container (HTML <div>) to help set
+        # function prototypes apart
+        self.lineprefix = "  "
+
+        if parameterlist:
+            print(".. container:: kernelindent\n")
+            print(f"{self.lineprefix}**Parameters**\n")
+
+        for parameter in parameterlist:
+            parameter_name = Re(r'\[.*').sub('', parameter)
+            dtype = args['parametertypes'].get(parameter, "")
+
+            if dtype:
+                print(f"{self.lineprefix}``{dtype}``")
+            else:
+                print(f"{self.lineprefix}``{parameter}``")
+
+            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+
+            self.lineprefix = "    "
+            if parameter_name in parameterdescs and \
+               parameterdescs[parameter_name] != KernelDoc.undescribed:
+
+                self.output_highlight(parameterdescs[parameter_name])
+                print()
+            else:
+                print(f"{self.lineprefix}*undescribed*\n")
+            self.lineprefix = "  "
+
+        self.out_section(args)
+        self.lineprefix = oldprefix
+
+    def out_enum(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        name = args.get('enum', '')
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        ln = args.get('ln', 0)
+
+        print(f"\n\n.. c:enum:: {name}\n")
+
+        self.print_lineno(ln)
+        self.lineprefix = "  "
+        self.output_highlight(args.get('purpose', ''))
+        print()
+
+        print(".. container:: kernelindent\n")
+        outer = self.lineprefix + "  "
+        self.lineprefix = outer + "  "
+        print(f"{outer}**Constants**\n")
+
+        for parameter in parameterlist:
+            print(f"{outer}``{parameter}``")
+
+            if parameterdescs.get(parameter, '') != KernelDoc.undescribed:
+                self.output_highlight(parameterdescs[parameter])
+            else:
+                print(f"{self.lineprefix}*undescribed*\n")
+            print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_typedef(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        name = args.get('typedef', '')
+        ln = args.get('ln', 0)
+
+        print(f"\n\n.. c:type:: {name}\n")
+
+        self.print_lineno(ln)
+        self.lineprefix = "   "
+
+        self.output_highlight(args.get('purpose', ''))
+
+        print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_struct(self, fname, name, args):
+
+        name = args.get('struct', "")
+        purpose = args.get('purpose', "")
+        declaration = args.get('definition', "")
+        dtype = args.get('type', "struct")
+        ln = args.get('ln', 0)
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
+
+        print(f"\n\n.. c:{dtype}:: {name}\n")
+
+        self.print_lineno(ln)
+
+        oldprefix = self.lineprefix
+        self.lineprefix += "  "
+
+        self.output_highlight(purpose)
+        print()
+
+        print(".. container:: kernelindent\n")
+        print(f"{self.lineprefix}**Definition**::\n")
+
+        self.lineprefix = self.lineprefix + "  "
+
+        declaration = declaration.replace("\t", self.lineprefix)
+
+        print(f"{self.lineprefix}{dtype} {name}" + ' {')
+        print(f"{declaration}{self.lineprefix}" + "};\n")
+
+        self.lineprefix = "  "
+        print(f"{self.lineprefix}**Members**\n")
+        for parameter in parameterlist:
+            if not parameter or parameter.startswith("#"):
+                continue
+
+            parameter_name = parameter.split("[", maxsplit=1)[0]
+
+            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+
+            print(f"{self.lineprefix}``{parameter}``")
+
+            self.lineprefix = "    "
+            self.output_highlight(parameterdescs[parameter_name])
+            self.lineprefix = "  "
+
+            print()
+
+        print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+
+class ManFormat(OutputFormat):
+    """Consts and functions used by man pages output"""
+
+    highlights = (
+        (type_constant, r"\1"),
+        (type_constant2, r"\1"),
+        (type_func, r"\\fB\1\\fP"),
+        (type_enum, r"\\fI\1\\fP"),
+        (type_struct, r"\\fI\1\\fP"),
+        (type_typedef, r"\\fI\1\\fP"),
+        (type_union, r"\\fI\1\\fP"),
+        (type_param, r"\\fI\1\\fP"),
+        (type_param_ref, r"\\fI\1\2\\fP"),
+        (type_member, r"\\fI\1\2\3\\fP"),
+        (type_fallback, r"\\fI\1\\fP")
+    )
+    blankline = ""
+
+    def __init__(self):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+
+        dt = datetime.now()
+        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
+            # use UTC TZ
+            to_zone = tz.gettz('UTC')
+            dt = dt.astimezone(to_zone)
+
+        self.man_date = dt.strftime("%B %Y")
+
+    def output_highlight(self, block):
+
+        contents = self.highlight_block(block)
+
+        if isinstance(contents, list):
+            contents = "\n".join(contents)
+
+        for line in contents.strip("\n").split("\n"):
+            line = Re(r"^\s*").sub("", line)
+
+            if line and line[0] == ".":
+                print("\\&" + line)
+            else:
+                print(line)
+
+    def out_doc(self, fname, name, args):
+        module = args.get('module')
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX')
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
+
+    def out_function(self, fname, name, args):
+        """output function in man"""
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"{args['function']} \\- {args['purpose']}")
+
+        print(".SH SYNOPSIS")
+        if args.get('functiontype', ''):
+            print(f'.B "{args['functiontype']}" {args['function']}')
+        else:
+            print(f'.B "{args['function']}')
+
+        count = 0
+        parenth = "("
+        post = ","
+
+        for parameter in parameterlist:
+            if count == len(parameterlist) - 1:
+                post = ");"
+
+            dtype = args['parametertypes'].get(parameter, "")
+            if function_pointer.match(dtype):
+                # Pointer-to-function
+                print(f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"')
+            else:
+                dtype = Re(r'([^\*])$').sub(r'\1 ', dtype)
+
+                print(f'.BI "{parenth}{dtype}"  "{post}"')
+            count += 1
+            parenth = ""
+
+        if parameterlist:
+            print(".SH ARGUMENTS")
+
+        for parameter in parameterlist:
+            parameter_name = re.sub(r'\[.*', '', parameter)
+
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(parameterdescs.get(parameter_name, ""))
+
+        for section in sectionlist:
+            print(f'.SH "{section.upper()}"')
+            self.output_highlight(sections[section])
+
+    def out_enum(self, fname, name, args):
+
+        name = args.get('enum', '')
+        parameterlist = args.get('parameterlist', [])
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"enum {args['enum']} \\- {args['purpose']}")
+
+        print(".SH SYNOPSIS")
+        print(f"enum {args['enum']}" + " {")
+
+        count = 0
+        for parameter in parameterlist:
+            print(f'.br\n.BI "    {parameter}"')
+            if count == len(parameterlist) - 1:
+                print("\n};")
+            else:
+                print(", \n.br")
+
+            count += 1
+
+        print(".SH Constants")
+
+        for parameter in parameterlist:
+            parameter_name = Re(r'\[.*').sub('', parameter)
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections[section])
+
+    def out_typedef(self, fname, name, args):
+        module = args.get('module')
+        typedef = args.get('typedef')
+        purpose = args.get('purpose')
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"typedef {typedef} \\- {purpose}")
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
+
+    def out_struct(self, fname, name, args):
+        module = args.get('module')
+        struct_type = args.get('type')
+        struct_name = args.get('struct')
+        purpose = args.get('purpose')
+        definition = args.get('definition')
+        sectionlist = args.get('sectionlist', [])
+        parameterlist = args.get('parameterlist', [])
+        sections = args.get('sections', {})
+        parameterdescs = args.get('parameterdescs', {})
+
+        print(f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"{struct_type} {struct_name} \\- {purpose}")
+
+        # Replace tabs with two spaces and handle newlines
+        declaration = definition.replace("\t", "  ")
+        declaration = Re(r"\n").sub('"\n.br\n.BI "', declaration)
+
+        print(".SH SYNOPSIS")
+        print(f"{struct_type} {struct_name} " + "{" + "\n.br")
+        print(f'.BI "{declaration}\n' + "};\n.br\n")
+
+        print(".SH Members")
+        for parameter in parameterlist:
+            if parameter.startswith("#"):
+                continue
+
+            parameter_name = re.sub(r"\[.*", "", parameter)
+
+            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(parameterdescs.get(parameter_name))
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
-- 
2.48.1


