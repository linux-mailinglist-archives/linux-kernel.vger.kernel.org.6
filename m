Return-Path: <linux-kernel+bounces-521114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94EA3B44E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA927188B70A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08361DFE32;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oioGjcgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD31DE3A3;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953973; cv=none; b=poBiO5ewwe8vi5fLNdpcc5XphQMM9IdOo5NzNdNQF+do7uEA/hjbqIg8grs/fiweWWMT5AXs+Hs21dEHdrEZBhUys+X9VacZ3OyLr4chMAN1Es3VKEHIj8MQzOGQqcKQvSKUkJVfeX3L9mNcsP4dHoJkiB8d/pZy0WPLbLXZ5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953973; c=relaxed/simple;
	bh=+233tNh0yGNXfYZxQx+uxFiZ7ugw73yF3W1jWprPI1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhprkR5d2wi1gxdLMmjv3u2yY7QYDPYtjprybGtJl7Zq976BAwx9p8Ftq4RqZeguBu0y+UsjK8SQ9ea4GfCYK4K4/SyoL6xfbyvHvYiqMMKhx8221TfZL4r0LuPsgFBJMJOgPWlF1UOAnyDw1LBR8zf2mBCRfemXCW1riC7e27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oioGjcgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED16C113CF;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=+233tNh0yGNXfYZxQx+uxFiZ7ugw73yF3W1jWprPI1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oioGjcgP/rgaQ16e0sJrzpota3HtAKniRKckPqbb6DHNKRZ9tLs4dBRxQm0hCDpsx
	 MPB70sZXo4FujDpA0OWNnC4wicBRDW3EwKsBDRdr0FI5PLKXmRUyg30qvDS8CKD3Mn
	 iymV0Lzi92El5a4h+mWlqiwahsN3+Z0bMglg0Tm2xzH1xxlhoCUkcW/iQRg0STHG96
	 NpKMMvNP9q0Kfyz8oRkKtVYJ4ONk2jscThcj2JOytHxG3ruzgJq+eAeZZLIxU+djcP
	 IVqp5lPVJcRUuJ/w/cu2WH2ceepHwVR7mBpnaWGDMowdaff33w4gIpAAKUcZDD2Sol
	 KYcdzC5upsgfw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5N-1e0G;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/27] scripts/kernel-doc.py: convert message output to an interactor
Date: Wed, 19 Feb 2025 09:32:33 +0100
Message-ID: <b7f64f70d4b7526a15d1eb990dfe840fe7589537.1739952783.git.mchehab+huawei@kernel.org>
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

Instead of directly printing output messages, change kdoc classes
to return an interactor with the output message, letting the
actual display to happen at the command-line command.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           |   9 +-
 scripts/lib/kdoc/kdoc_files.py  |  15 ++-
 scripts/lib/kdoc/kdoc_output.py | 171 ++++++++++++++++----------------
 3 files changed, 104 insertions(+), 91 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 0596c711d448..6c3179a2da65 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -208,9 +208,12 @@ def main():
 
     kfiles.parse()
 
-    kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
-               internal=args.internal, symbol=args.symbol,
-               nosymbol=args.nosymbol)
+    for t in kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
+                          internal=args.internal, symbol=args.symbol,
+                          nosymbol=args.nosymbol):
+        msg = t[1]
+        if msg:
+            print(msg)
 
 
 # Call main method
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 76dd53611c08..434fc66a9dad 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -228,9 +228,10 @@ class KernelFiles():
 
     def out_msg(self, fname, name, arg):
         """
-        Output messages from a file name using the output style filtering.
+        Return output messages from a file name using the output style
+        filtering.
 
-        If output type was not handled by the syler, return False.
+        If output type was not handled by the syler, return None.
         """
 
         # NOTE: we can add rules here to filter out unwanted parts,
@@ -241,7 +242,8 @@ class KernelFiles():
     def msg(self, enable_lineno=False, export=False, internal=False,
             symbol=None, nosymbol=None):
         """
-        Interacts over the kernel-doc results and output messages.
+        Interacts over the kernel-doc results and output messages,
+        returning kernel-doc markups on each interaction
         """
 
         function_table = self.config.function_table
@@ -260,10 +262,15 @@ class KernelFiles():
                                   function_table, enable_lineno)
 
         for fname, arg_tuple in self.results:
+            msg = ""
             for name, arg in arg_tuple:
-                if self.out_msg(fname, name, arg):
+                msg += self.out_msg(fname, name, arg)
+
+                if msg is None:
                     ln = arg.get("ln", 0)
                     dtype = arg.get('type', "")
 
                     self.config.log.warning("%s:%d Can't handle %s",
                                             fname, ln, dtype)
+            if msg:
+                yield fname, msg
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index d080440caa1c..91f6e356d03d 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -70,6 +70,8 @@ class OutputFormat:
         self.function_table = set()
         self.config = None
 
+        self.data = ""
+
     def set_config(self, config):
         self.config = config
 
@@ -156,37 +158,38 @@ class OutputFormat:
         return True
 
     def msg(self, fname, name, args):
+        self.data = ""
 
         dtype = args.get('type', "")
 
         if dtype == "doc":
             self.out_doc(fname, name, args)
-            return False
+            return self.data
 
         if not self.check_declaration(dtype, name):
-            return False
+            return self.data
 
         if dtype == "function":
             self.out_function(fname, name, args)
-            return False
+            return self.data
 
         if dtype == "enum":
             self.out_enum(fname, name, args)
-            return False
+            return self.data
 
         if dtype == "typedef":
             self.out_typedef(fname, name, args)
-            return False
+            return self.data
 
         if dtype in ["struct", "union"]:
             self.out_struct(fname, name, args)
-            return False
+            return self.data
 
         # Warn if some type requires an output logic
         self.config.log.warning("doesn't now how to output '%s' block",
                                 dtype)
 
-        return True
+        return None
 
     # Virtual methods to be overridden by inherited classes
     def out_doc(self, fname, name, args):
@@ -247,7 +250,7 @@ class RestFormat(OutputFormat):
         """Outputs a line number"""
 
         if self.enable_lineno and ln:
-            print(f".. LINENO {ln}")
+            self.data += f".. LINENO {ln}\n"
 
     def output_highlight(self, args):
         input_text = args
@@ -294,7 +297,7 @@ class RestFormat(OutputFormat):
 
         # Print the output with the line prefix
         for line in output.strip("\n").split("\n"):
-            print(self.lineprefix + line)
+            self.data += self.lineprefix + line + "\n"
 
     def out_section(self, args, out_reference=False):
         """
@@ -316,15 +319,15 @@ class RestFormat(OutputFormat):
 
             if not self.out_mode == self.OUTPUT_INCLUDE:
                 if out_reference:
-                    print(f".. _{section}:\n")
+                    self.data += f".. _{section}:\n\n"
 
                 if not self.symbol:
-                    print(f'{self.lineprefix}**{section}**\n')
+                    self.data += f'{self.lineprefix}**{section}**\n\n'
 
             self.print_lineno(section_start_lines.get(section, 0))
             self.output_highlight(sections[section])
-            print()
-        print()
+            self.data += "\n"
+        self.data += "\n"
 
     def out_doc(self, fname, name, args):
         if not self.check_doc(name):
@@ -367,42 +370,42 @@ class RestFormat(OutputFormat):
             signature += ")"
 
         if args.get('typedef') or not args.get('functiontype'):
-            print(f".. c:macro:: {args['function']}\n")
+            self.data += f".. c:macro:: {args['function']}\n\n"
 
             if args.get('typedef'):
                 self.print_lineno(ln)
-                print("   **Typedef**: ", end="")
+                self.data += "   **Typedef**: "
                 self.lineprefix = ""
                 self.output_highlight(args.get('purpose', ""))
-                print("\n\n**Syntax**\n")
-                print(f"  ``{signature}``\n")
+                self.data += "\n\n**Syntax**\n\n"
+                self.data += f"  ``{signature}``\n\n"
             else:
-                print(f"``{signature}``\n")
+                self.data += f"``{signature}``\n\n"
         else:
-            print(f".. c:function:: {signature}\n")
+            self.data += f".. c:function:: {signature}\n\n"
 
         if not args.get('typedef'):
             self.print_lineno(ln)
             self.lineprefix = "   "
             self.output_highlight(args.get('purpose', ""))
-            print()
+            self.data += "\n"
 
         # Put descriptive text into a container (HTML <div>) to help set
         # function prototypes apart
         self.lineprefix = "  "
 
         if parameterlist:
-            print(".. container:: kernelindent\n")
-            print(f"{self.lineprefix}**Parameters**\n")
+            self.data += ".. container:: kernelindent\n\n"
+            self.data += f"{self.lineprefix}**Parameters**\n\n"
 
         for parameter in parameterlist:
             parameter_name = Re(r'\[.*').sub('', parameter)
             dtype = args['parametertypes'].get(parameter, "")
 
             if dtype:
-                print(f"{self.lineprefix}``{dtype}``")
+                self.data += f"{self.lineprefix}``{dtype}``\n"
             else:
-                print(f"{self.lineprefix}``{parameter}``")
+                self.data += f"{self.lineprefix}``{parameter}``\n"
 
             self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
 
@@ -411,9 +414,9 @@ class RestFormat(OutputFormat):
                parameterdescs[parameter_name] != KernelDoc.undescribed:
 
                 self.output_highlight(parameterdescs[parameter_name])
-                print()
+                self.data += "\n"
             else:
-                print(f"{self.lineprefix}*undescribed*\n")
+                self.data += f"{self.lineprefix}*undescribed*\n\n"
             self.lineprefix = "  "
 
         self.out_section(args)
@@ -427,26 +430,26 @@ class RestFormat(OutputFormat):
         parameterdescs = args.get('parameterdescs', {})
         ln = args.get('ln', 0)
 
-        print(f"\n\n.. c:enum:: {name}\n")
+        self.data += f"\n\n.. c:enum:: {name}\n\n"
 
         self.print_lineno(ln)
         self.lineprefix = "  "
         self.output_highlight(args.get('purpose', ''))
-        print()
+        self.data += "\n"
 
-        print(".. container:: kernelindent\n")
+        self.data += ".. container:: kernelindent\n\n"
         outer = self.lineprefix + "  "
         self.lineprefix = outer + "  "
-        print(f"{outer}**Constants**\n")
+        self.data += f"{outer}**Constants**\n\n"
 
         for parameter in parameterlist:
-            print(f"{outer}``{parameter}``")
+            self.data += f"{outer}``{parameter}``\n"
 
             if parameterdescs.get(parameter, '') != KernelDoc.undescribed:
                 self.output_highlight(parameterdescs[parameter])
             else:
-                print(f"{self.lineprefix}*undescribed*\n")
-            print()
+                self.data += f"{self.lineprefix}*undescribed*\n\n"
+            self.data += "\n"
 
         self.lineprefix = oldprefix
         self.out_section(args)
@@ -457,14 +460,14 @@ class RestFormat(OutputFormat):
         name = args.get('typedef', '')
         ln = args.get('ln', 0)
 
-        print(f"\n\n.. c:type:: {name}\n")
+        self.data += f"\n\n.. c:type:: {name}\n\n"
 
         self.print_lineno(ln)
         self.lineprefix = "   "
 
         self.output_highlight(args.get('purpose', ''))
 
-        print()
+        self.data += "\n"
 
         self.lineprefix = oldprefix
         self.out_section(args)
@@ -481,7 +484,7 @@ class RestFormat(OutputFormat):
         parameterdescs = args.get('parameterdescs', {})
         parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
 
-        print(f"\n\n.. c:{dtype}:: {name}\n")
+        self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
 
         self.print_lineno(ln)
 
@@ -489,20 +492,20 @@ class RestFormat(OutputFormat):
         self.lineprefix += "  "
 
         self.output_highlight(purpose)
-        print()
+        self.data += "\n"
 
-        print(".. container:: kernelindent\n")
-        print(f"{self.lineprefix}**Definition**::\n")
+        self.data += ".. container:: kernelindent\n\n"
+        self.data += f"{self.lineprefix}**Definition**::\n\n"
 
         self.lineprefix = self.lineprefix + "  "
 
         declaration = declaration.replace("\t", self.lineprefix)
 
-        print(f"{self.lineprefix}{dtype} {name}" + ' {')
-        print(f"{declaration}{self.lineprefix}" + "};\n")
+        self.data += f"{self.lineprefix}{dtype} {name}" + ' {' + "\n"
+        self.data += f"{declaration}{self.lineprefix}" + "};\n\n"
 
         self.lineprefix = "  "
-        print(f"{self.lineprefix}**Members**\n")
+        self.data += f"{self.lineprefix}**Members**\n\n"
         for parameter in parameterlist:
             if not parameter or parameter.startswith("#"):
                 continue
@@ -514,15 +517,15 @@ class RestFormat(OutputFormat):
 
             self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
 
-            print(f"{self.lineprefix}``{parameter}``")
+            self.data += f"{self.lineprefix}``{parameter}``\n"
 
             self.lineprefix = "    "
             self.output_highlight(parameterdescs[parameter_name])
             self.lineprefix = "  "
 
-            print()
+            self.data += "\n"
 
-        print()
+        self.data += "\n"
 
         self.lineprefix = oldprefix
         self.out_section(args)
@@ -575,19 +578,19 @@ class ManFormat(OutputFormat):
             line = Re(r"^\s*").sub("", line)
 
             if line and line[0] == ".":
-                print("\\&" + line)
+                self.data += "\\&" + line + "\n"
             else:
-                print(line)
+                self.data += line + "\n"
 
     def out_doc(self, fname, name, args):
         module = args.get('module')
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        print(f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX')
+        self.data += f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         for section in sectionlist:
-            print(f'.SH "{section}"')
+            self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
 
     def out_function(self, fname, name, args):
@@ -598,16 +601,16 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        print(f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX')
+        self.data += f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
 
-        print(".SH NAME")
-        print(f"{args['function']} \\- {args['purpose']}")
+        self.data += ".SH NAME\n"
+        self.data += f"{args['function']} \\- {args['purpose']}\n"
 
-        print(".SH SYNOPSIS")
+        self.data += ".SH SYNOPSIS\n"
         if args.get('functiontype', ''):
-            print(f'.B "{args['functiontype']}" {args['function']}')
+            self.data += f'.B "{args['functiontype']}" {args['function']}' + "\n"
         else:
-            print(f'.B "{args['function']}')
+            self.data += f'.B "{args['function']}' + "\n"
 
         count = 0
         parenth = "("
@@ -620,25 +623,25 @@ class ManFormat(OutputFormat):
             dtype = args['parametertypes'].get(parameter, "")
             if function_pointer.match(dtype):
                 # Pointer-to-function
-                print(f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"')
+                self.data += f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
             else:
                 dtype = Re(r'([^\*])$').sub(r'\1 ', dtype)
 
-                print(f'.BI "{parenth}{dtype}"  "{post}"')
+                self.data += f'.BI "{parenth}{dtype}"  "{post}"' + "\n"
             count += 1
             parenth = ""
 
         if parameterlist:
-            print(".SH ARGUMENTS")
+            self.data += ".SH ARGUMENTS\n"
 
         for parameter in parameterlist:
             parameter_name = re.sub(r'\[.*', '', parameter)
 
-            print(f'.IP "{parameter}" 12')
+            self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(parameterdescs.get(parameter_name, ""))
 
         for section in sectionlist:
-            print(f'.SH "{section.upper()}"')
+            self.data += f'.SH "{section.upper()}"' + "\n"
             self.output_highlight(sections[section])
 
     def out_enum(self, fname, name, args):
@@ -648,33 +651,33 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        print(f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX')
+        self.data += f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
-        print(".SH NAME")
-        print(f"enum {args['enum']} \\- {args['purpose']}")
+        self.data += ".SH NAME\n"
+        self.data += f"enum {args['enum']} \\- {args['purpose']}\n"
 
-        print(".SH SYNOPSIS")
-        print(f"enum {args['enum']}" + " {")
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"enum {args['enum']}" + " {\n"
 
         count = 0
         for parameter in parameterlist:
-            print(f'.br\n.BI "    {parameter}"')
+            self.data += f'.br\n.BI "    {parameter}"' + "\n"
             if count == len(parameterlist) - 1:
-                print("\n};")
+                self.data += "\n};\n"
             else:
-                print(", \n.br")
+                self.data += ", \n.br\n"
 
             count += 1
 
-        print(".SH Constants")
+        self.data += ".SH Constants\n"
 
         for parameter in parameterlist:
             parameter_name = Re(r'\[.*').sub('', parameter)
-            print(f'.IP "{parameter}" 12')
+            self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
 
         for section in sectionlist:
-            print(f'.SH "{section}"')
+            self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections[section])
 
     def out_typedef(self, fname, name, args):
@@ -684,13 +687,13 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        print(f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX')
+        self.data += f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
-        print(".SH NAME")
-        print(f"typedef {typedef} \\- {purpose}")
+        self.data += ".SH NAME\n"
+        self.data += f"typedef {typedef} \\- {purpose}\n"
 
         for section in sectionlist:
-            print(f'.SH "{section}"')
+            self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
 
     def out_struct(self, fname, name, args):
@@ -704,20 +707,20 @@ class ManFormat(OutputFormat):
         sections = args.get('sections', {})
         parameterdescs = args.get('parameterdescs', {})
 
-        print(f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX')
+        self.data += f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
-        print(".SH NAME")
-        print(f"{struct_type} {struct_name} \\- {purpose}")
+        self.data += ".SH NAME\n"
+        self.data += f"{struct_type} {struct_name} \\- {purpose}\n"
 
         # Replace tabs with two spaces and handle newlines
         declaration = definition.replace("\t", "  ")
         declaration = Re(r"\n").sub('"\n.br\n.BI "', declaration)
 
-        print(".SH SYNOPSIS")
-        print(f"{struct_type} {struct_name} " + "{" + "\n.br")
-        print(f'.BI "{declaration}\n' + "};\n.br\n")
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"{struct_type} {struct_name} " + "{" + "\n.br\n"
+        self.data += f'.BI "{declaration}\n' + "};\n.br\n\n"
 
-        print(".SH Members")
+        self.data += ".SH Members\n"
         for parameter in parameterlist:
             if parameter.startswith("#"):
                 continue
@@ -727,9 +730,9 @@ class ManFormat(OutputFormat):
             if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
                 continue
 
-            print(f'.IP "{parameter}" 12')
+            self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(parameterdescs.get(parameter_name))
 
         for section in sectionlist:
-            print(f'.SH "{section}"')
+            self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
-- 
2.48.1


